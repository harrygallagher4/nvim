(module dotfiles.scratch.parinfer)

(local ffi (require :ffi))
(local util (require :dotfiles.util))
(local cmds (require :dotfiles.commands))
(local a (require :aniseed.core))
(local nvim (require :aniseed.nvim))
(local f (require :fun))
(local {:interface parinfer : logs : log-storage} (require :dotfiles.scratch.parinfer-state))
(local json vim.json)

(local bufnr vim.fn.bufnr)
(local exists vim.fn.exists)
(local expand vim.fn.expand)
(local getline vim.fn.getline)
(local matchstr vim.fn.matchstr)
(local setpos vim.fn.setpos)
(local win_gettype vim.fn.win_gettype)


(local state {:mode "smart"})


(fn run-parinfer [request]
  "sends `request` as json to parinfer"
  (-> request
      (json.encode) (parinfer.run_parinfer) (ffi.string) (json.decode)))

(fn get-cursor []
  "gets cursor position, (0, 0) indexed"
  (let [[row col] (nvim.win_get_cursor 0)]
    [(- row 1) col]))

(fn set-cursor [row col]
  "sets cursor position, (0, 0) indexed"
  (nvim.win_set_cursor 0 [(+ row 1) col]))

(fn get-buf-content []
  "gets entire buffer text as one string"
  (table.concat
    (nvim.buf_get_lines 0 0 -1 false)
    "\n"))

(fn make-processor [buf]
  "make a process-buffer function with enclosed settings"
  (let [commentChar ";" stringDelimiters ["\""]
        forceBalance false lispVlineSymbols false lispBlockComments false
        guileBlockComments false schemeSexpComments false janetLongStrings false]
    (fn process []
      (when (~= (. state buf :changedtick) (nvim.buf_get_changedtick buf))
        (let [[cl cx] (get-cursor)
              original-text (get-buf-content)
              bufstate (. state buf)
              req
              {:mode state.mode
               :text original-text
               :options
               {: commentChar : stringDelimiters : forceBalance
                : lispVlineSymbols : lispBlockComments : guileBlockComments
                : schemeSexpComments : janetLongStrings
                :cursorX cx
                :cursorLine cl
                :prevCursorX bufstate.cursorX
                :prevCursorLine bufstate.cursorLine
                :prevText bufstate.text}}
              response (run-parinfer req)]
          (if response.success
            (do
              (when (~= response.text original-text)
                (vim.cmd "silent! undojoin")
                (nvim.buf_set_lines buf 0 -1 false (vim.split response.text "\n")))
              (set-cursor response.cursorLine response.cursorX)
              (tset state buf :text response.text))
            (do
              (tset state buf :error response.error)
              (tset state buf :text (get-buf-content)))))
        (tset state buf :changedtick (nvim.buf_get_changedtick buf)))
      (let [[cl cx] (get-cursor)]
        (tset state buf :cursorLine cl)
        (tset state buf :cursorX cx)))))

(fn refresh-cursor [buf]
  #(let [[cl cx] (get-cursor)]
     (tset state buf :cursorX cx)
     (tset state buf :cursorLine cl)))

(fn refresh-text [buf]
  (let [ct (nvim.buf_get_changedtick buf)]
    (when (~= ct (. state buf :changedtick))
      (tset state buf :changedtick ct)
      (tset state buf :text (nvim.buf_get_lines buf 0 -1 false)))))

(fn refresher [buf]
  (let [ref-c (refresh-cursor buf)]
    #(do (refresh-text buf) (ref-c))))

(fn enter-buffer [buf]
  (when (= nil (. state buf))
    (let [[cl cx] (get-cursor) proc (make-processor buf)]
      (tset state buf {:text (get-buf-content) :process proc :changedtick -1
                       :cursorX cx :cursorLine cl})
      (nvim.create_autocmd
        [:CursorMoved :InsertEnter :TextChanged :TextChangedI :TextChangedP]
        {:callback proc :buffer buf :group "parinfennel"})
      (nvim.create_autocmd
        [:BufEnter :WinEnter]
        {:callback (refresh-cursor buf) :buffer buf :group "parinfennel"})
      (nvim.create_autocmd
        :InsertCharPre
        {:callback (refresher buf) :buffer buf :group "parinfennel"})))
  (let [original-mode state.mode]
    (tset state :mode "paren")
    ((. state buf :process))
    (tset state :mode original-mode)))

(fn initialize-buffer []
  (when (= "" (win_gettype))
    (enter-buffer (expand "<abuf>"))))

(defn setup! []
  (nvim.create_augroup "parinfennel" {:clear true})
  (nvim.create_autocmd "FileType"
    {:group "parinfennel"
     :pattern ["clojure" "scheme" "lisp" "racket" "hy" "fennel" "janet" "carp" "wast" "yuck" "dune"]
     :callback initialize-buffer}))

(fn cleanup []
  (nvim.del_augroup_by_name "parinfennel"))

(defn attach-current-buf! []
  (tset vim.g :parinfer_enabled 0)
  (let [buf (nvim.get_current_buf)]
    (enter-buffer buf)))

(nvim.create_augroup "parinfennel" {:clear true})
(cmds.mod-cmd! :ParinferFnlOn *module-name* :attach-current-buf!)

