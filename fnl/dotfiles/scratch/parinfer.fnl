"
(#$ logs)
(#$ log-storage)"

(module dotfiles.scratch.parinfer)

(local ffi (require :ffi))
(local util (require :dotfiles.util))
(local a (require :aniseed.core))
(local f (require :fun))
(local {:interface parinfer : logs : log-storage} (require :dotfiles.scratch.parinfer-state))
(local json vim.json)

;; parinfer doesn't log unless this is set
(tset vim.g :parinfer_log_fnl 1)

(fn run-parinfer [request]
  "sends `request` as json to parinfer"
  (-> request
      (json.encode) (parinfer.run_parinfer) (ffi.string) (json.decode)))

(fn get-cursor []
  "gets cursor position, (0, 0) indexed"
  (let [[row col] (vim.api.nvim_win_get_cursor 0)]
    [(- row 1) col]))

;; not exactly sure what to do with this yet, the vimscript version has
;; some weird logic going on. <plugin/parinfer.vim:150>
(fn set-cursor [pos]
  "sets cursor position, (0, 0) indexed"
  (let
    [cursor [(+ 1 (. pos 1)) (+ 1 (. pos 2))]
     line (vim.fn.getline (. cursor 1))
     head (vim.fn.matchstr line (.. ".\\+\\%<" (+ 1 (. cursor 2)) "v"))
     col (+ 1 (string.len head))]
    (vim.fn.setpos "." [(. cursor 1) col])))
; (fn set-cursor [pos]
;   "sets cursor position, (0, 0) indexed"
;   (-> (vim.fn.getline (. pos 1))
;       (vim.fn.matchstr (.. ".\\+\\%<" (. pos 2) "v"))
;       (string.len)
;       (+ 1)))

(fn get-buf-content []
  "gets entire buffer text as one string"
  (table.concat
    (vim.api.nvim_buf_get_lines 0 0 -1 false)
    "\n"))

(local cursor (get-cursor))
(local request
  {:mode "smart"
   :text (get-buf-content)
   :options
   {:comment_char ";"
    :stringDelimiters ["\""]
    :cursorX (. cursor 2)
    :cursorLine (. cursor 1)
    :forceBalance false
    :lispVlineSymbols false
    :lispBlockComments false
    :guileBlockComments false
    :schemeSexpComments false
    :janetLongStrings false
    :prevCursorX 0
    :prevCursorLine 0
    :prevText vim.b.parinfer_previous_text}})

(local response (run-parinfer request))


;;
;; string diff stuff below this point
;;


(fn char-indices [s]
  (var [r i] [[] 0])
  (each [c (string.gmatch s ".")]
    (set i (+ 1 i))
    (table.insert r [i c])) r)
(fn tbl-reverse [t]
  (local r [])
  (for [i (length t) 1 -1]
    (table.insert r (. t i))) r)

;; compute_text_changes *directly* copied from parinfer
;; *directly* except for computing idx ahead of time
(fn compute-text-changes [prev-text text]
  (var [x line-no start-text start-prev different] [1 1 1 1 false])
  (var end-text (string.len text))
  (var end-prev (string.len prev-text))
  (local prev-idx (char-indices prev-text))
  (local text-idx (char-indices text))

  (each [_ [i pc] [j c] (f.zip prev-idx text-idx)]
    (when (~= pc c)
      (set start-prev i)
      (set start-text j)
      (set different true)
      (lua "break"))
    (if (= pc "\n")
        (do (set x 1)
            (set line-no (+ 1 line-no)))
        (set x (+ 1 x))))

  (each [_ [i pc] [j c] (f.zip (tbl-reverse prev-idx) (tbl-reverse text-idx))]
    (when (or (~= pc c) (< i start-prev) (< j start-text))
      (set end-prev (+ i 0))
      (set end-text (+ j 0))
      (lua "break")))

  (if different
    [x line-no
     (string.sub prev-text start-prev end-prev)
     (string.sub text start-text end-text)]
    []))

(local cs
  (collect [k v (pairs {:lparen 40 :rparen 41 :lbrak 91 :rbrak 93 :lcurl 123 :rcurl 125})]
    k (string.char v)))

(compute-text-changes (.. "abcd" cs.rparen) "abcdef")
(compute-text-changes "hello" "hexlo") ; -> [3 1 "l" "x"] change 1:3 from l to x
(compute-text-changes "he\nllo" "he\nxlo") ; -> [1 2 "l" "x"] change 2:1 from l to x
(compute-text-changes "hello" "helllo") ; -> [5 1 "" "l"] insert l at index 5
(compute-text-changes "helllo" "hello") ; -> [5 1 "l" ""] delete l at index 5
(compute-text-changes "<abcd>f" "<abcdf")


(fn simple-change? [s1 s2]
  "test if either string is contained in the other"
  (let [(i j) (string.find s1 s2)]
    (if (or i j) [1 s1 [i j]]
      (let [(v u) (string.find s2 s1)]
        (when (or v u) [2 s2 [v u]])))))


;;
;; back to parinfer
;;


(fn process-buffer []
  "parinfer.vim copies global variables to the buffer here"
  (when (~= vim.b.parinfer_last_changedtick vim.b.changedtick)
    (let [cursor (get-cursor)
          original-text (get-buf-content)
          req {:mode vim.g.parinfer_mode
               :text original-text
               :options
               {:commentChar vim.b.parinfer_comment_char
                :stringDelimiters ["\""]
                :cursorX (. cursor 2)
                :cursorLine (. cursor 1)
                :forceBalance false
                :lispVlineSymbols false
                :lispBlockComments false
                :guileBlockComments false
                :schemeSexpComments false
                :janetLongStrings false
                :prevCursorX (. vim.w.parinfer_previous_cursor 2)
                :prevCursorLine (. vim.w.parinfer_previous_cursor 1)
                :prevText vim.b.parinfer_previous_text}}
          response (run-parinfer req)]
      (if (. response :success)
        (do (when (~= (. response :text) original-text)
              "log stuff"
              (vim.cmd "silent! undojoin") ; wonder if there's an api function for this
              (#"change-buffer-text" (. response :text)))
            (set-cursor (. response :cursorLine) (. response :cursorX))
            (tset vim.b :parinfer_previous_text (. response :text)))
        (do (tset vim.g :parinfer_last_error (. response :error))
            (tset vim.b :parinfer_previous_text (get-buf-content))))))
  (tset vim.w :parinfer_previous_cursor (get-cursor)))

(fn enter-window []
  (tset vim.w :parinfer_previous_cursor (get-cursor)))

(fn enter-buffer []
  (enter-window)
  (when (not (vim.fn.exists "b:parinfer_last_changedtick"))
    (tset vim.b :parinfer_last_changedtick -10)
    (tset vim.b :parinfer_previous_text (get-buf-content)))
  (let [original-mode vim.g.parinfer_mode]
    (tset vim.g :parinfer_mode "paren")
    (process-buffer)
    (tset vim.g :parinfer_mode original-mode)))

(local events
  (collect [k v
            (pairs
              {:BufEnter #"enter-buffer"
               :CursorMoved #"process-buffer"
               :InsertCharPre #"process-buffer"
               :InsertEnter #"process-buffer"
               :TextChanged #"process-buffer"
               :TextChangedI #"process-buffer"
               :TextChangedP #"process-buffer"
               :WinEnter #"enter-window"})]
    (when (vim.fn.exists (.. "##" k)) k) v))

(fn do-event [e]
  (when (= 1 vim.g.parinfer_log_fnl)
    (pr "event" {:name name :bufnr (vim.fn.bufnr "%") :changedtick vim.b.changedtick}))
  ((. events e)))

(fn initialize-buffer []
  (when (and (not (= (vim.fn.getcmdwintype) ""))
             (not vim.wo.previewwindow))
    "for event in events set buffer autocmd"))

; augroup Parinfer
;   autocmd FileType clojure,scheme,lisp,racket,hy,fennel,janet,carp,wast,yuck,dune call <SID>initialize_buffer()
; augroup END

; (let [{:ctime {: sec}} (vim.loop.fs_stat "/Users/harry/.config/nvim/fnl/dummy.fnl")]
;   (os.date "*t" sec))

