(module dotfiles.scratch.parinfer
  {require
   {ffi ffi
    cmds dotfiles.commands
    a aniseed.core
    parinfer-state dotfiles.scratch.parinfer-state}})

(local {:interface parinfer} parinfer-state)
(local json vim.json)

; I've heard that enclosing functions can slightly improve speed due to
; reducing the number of table lookups, but who knows. I figure if
; there's a small performance gain it's worth it since a lot of these
; will be called very often
;
; vim.fn functions
(local expand vim.fn.expand)
(local win_gettype vim.fn.win_gettype)
(local str2nr vim.fn.str2nr)
; api functions
(local create_augroup vim.api.nvim_create_augroup)
(local create_autocmd vim.api.nvim_create_autocmd)
(local del_augroup_by_id vim.api.nvim_del_augroup_by_id)
(local win_get_cursor vim.api.nvim_win_get_cursor)
(local win_set_cursor vim.api.nvim_win_set_cursor)
(local get_current_buf vim.api.nvim_get_current_buf)
(local buf_get_changedtick vim.api.nvim_buf_get_changedtick)
(local buf_set_lines vim.api.nvim_buf_set_lines)
(local buf_get_lines vim.api.nvim_buf_get_lines)

(local process-events [:CursorMoved :InsertEnter :TextChanged :TextChangedI :TextChangedP])
(local cursor-events [:BufEnter :WinEnter])

(local state {:mode "smart" :augroup nil})

; creates parinfennel augroup if necessary & stores id in state
(fn ensure-augroup []
  (when (= nil state.augroup)
    (tset state :augroup (create_augroup "parinfennel" {:clear true}))))

; deletes parinfennel augroup if it exists
(fn del-augroup []
  (when (~= nil state.augroup)
    (del_augroup_by_id state.augroup)
    (tset state :augroup nil)))

; creates an autocmd in `parinfennel` group
(fn autocmd [events opts]
  (create_autocmd events (a.merge opts {:group "parinfennel"})))

; shorthand for attaching a callback to a buffer
(fn buf-autocmd [buf events func]
  (table.insert
    (. state buf :autocmds)
    (autocmd events {:callback func :buffer buf})))

; expands autocmd buffer argument and converts to a number
(fn abuf []
  (str2nr (expand "<abuf>")))

; sends `request` as json to parinfer
(fn run-parinfer [request]
  (-> request (json.encode) (parinfer.run_parinfer) (ffi.string) (json.decode)))

; gets cursor position, (0, 0) indexed
(fn get-cursor []
  (let [[row col] (win_get_cursor 0)]
    (values (- row 1) col)))

; sets cursor position, (0, 0) indexed
(fn set-cursor [row col]
  (win_set_cursor 0 [(+ row 1) col]))

; gets entire buffer text as one string
(fn get-buf-content [buf]
  (table.concat (buf_get_lines buf 0 -1 false) "\n"))

; creates a function that refreshes the state of buf's changedtick
(fn refresh-changedtick [buf]
  #(tset state buf :changedtick (buf_get_changedtick buf)))

; creates a function that refreshes the state of buf's cursor position
(fn refresh-cursor [buf]
  #(let [(cl cx) (get-cursor)]
     (tset state buf :cursorX cx)
     (tset state buf :cursorLine cl)))

; creates a function that refreshes the state of buf's text & changedtick
(fn refresh-text [buf]
  #(let [ct (buf_get_changedtick buf)]
     (when (~= ct (. state buf :changedtick))
       (tset state buf :changedtick ct)
       (tset state buf :text (buf_get_lines buf 0 -1 false)))))

; creates a function that refreshes the state of
; buf's cursor, text, and changedtick
(fn refresher [buf]
  (let [ref-t (refresh-text buf) ref-c (refresh-cursor buf)]
    #(do (ref-t) (ref-c))))

; make a process-buffer function with enclosed settings
(fn make-processor [buf]
  (let [commentChar ";" stringDelimiters ["\""] forceBalance false
        lispVlineSymbols false lispBlockComments false guileBlockComments false
        schemeSexpComments false janetLongStrings false
        refresh-cursor (refresh-cursor buf) refresh-text (refresh-text buf)
        refresh-changedtick (refresh-changedtick buf)]

    (fn process []

      (when (~= (. state buf :changedtick) (buf_get_changedtick buf))
        (let [(cl cx) (get-cursor)
              original-text (get-buf-content buf)
              bufstate (. state buf)
              req
              {:mode state.mode
               :text original-text
               :options
               {: commentChar : stringDelimiters : forceBalance
                : lispVlineSymbols : lispBlockComments : guileBlockComments
                : schemeSexpComments : janetLongStrings
                :cursorX cx :cursorLine cl
                :prevCursorX bufstate.cursorX
                :prevCursorLine bufstate.cursorLine
                :prevText bufstate.text}}
              response (run-parinfer req)]

          (if response.success
            (do
              (when (~= response.text original-text)
                (vim.cmd "silent! undojoin")
                (buf_set_lines buf 0 -1 false (vim.split response.text "\n")))
              (set-cursor response.cursorLine response.cursorX)
              (tset state buf :text response.text))
            (do
              (tset state buf :error response.error)
              (refresh-text))))

        (refresh-changedtick))

      (refresh-cursor))))


; initialize buffer state if necessary, process buffer in paren mode
(fn enter-buffer [buf]
  (when (= nil (. state buf))
    (let [(cl cx) (get-cursor)
          proc (make-processor buf)]
      (tset
        state buf
        {:process proc
         :text (get-buf-content buf)
         :autocmds []
         :changedtick -1
         :cursorX cx :cursorLine cl})
      (buf-autocmd buf process-events proc)
      (buf-autocmd buf cursor-events (refresh-cursor buf))))

  (let [original-mode state.mode]
    (vim.schedule_wrap
      (fn []
        (tset state :mode "paren")
        (vim.cmd "execute \"normal! i\\<C-G>u\\<ESC>\"")
        ((. state buf :process))
        (tset state :mode original-mode)))))


; initializes a buffer if its window isn't a special type (qflist/etc)
(fn initialize-buffer []
  (when (= "" (win_gettype))
    (enter-buffer (abuf))))

; removes process callbacks associated with buf
(fn detach-buffer [buf]
  (each [_ v (ipairs (. state buf :autocmds))]
    (vim.api.nvim_del_autocmd v))
  (tset state buf nil))

; sets up autocmds to initialize new buffers
(defn setup! []
  (ensure-augroup)
  (autocmd :FileType
    {:pattern "clojure,scheme,lisp,racket,hy,fennel,janet,carp,wast,yuck,dune"
     :callback initialize-buffer}))

; delete parinfennel augroup which contains the init callback & all processors
(defn cleanup! []
  (del-augroup))

;; Only used for :ParinferFnlOn, disables parinfer-rust & attaches to
; current buffer only
(defn attach-current-buf! []
  (tset vim.g :parinfer_enabled 0)
  (ensure-augroup)
  (let [buf (get_current_buf)]
    (enter-buffer buf)))

; Only used for :ParinferOff, detaches from current buffer
(defn detach-current-buf! []
  (let [buf (get_current_buf)]
    (detach-buffer buf)))

;; if parinfer-rust is active commands should start with :ParinferFnl,
; otherwise they just start with :Parinfer
(fn cmd-str [s]
  (let [prefix (if (= 1 vim.g.parinfer_enabled) :ParinferFnl :Parinfer)]
    (.. prefix s)))

(cmds.mod-cmd! (cmd-str :On) *module-name* :attach-current-buf!)
(cmds.mod-cmd! (cmd-str :Off) *module-name* :detach-current-buf!)
(cmds.mod-cmd! (cmd-str :Setup) *module-name* :setup!)
(cmds.mod-cmd! (cmd-str :Cleanup) *module-name* :cleanup!)

