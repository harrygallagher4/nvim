
(fn get-cursor-tabs []
  "gets cursor position, (0, 0) indexed. takes tab width into account"
  (let [cursor (vim.api.nvim_win_get_cursor 0)]
    [(row cursor -1)
     (+ -1 (vim.fn.virtcol "."))]))
(fn get-cursor-position []
  "gets cursor position, (0, 0) indexed. directly adapted from vimscript version"
  (let [cursor (vim.fn.getpos ".")
        line (vim.fn.getline ".")]
    [(. cursor 1)
     (- (. cursor 2) 1)
     (vim.fn.strdisplaywidth (vim.fn.strpart line 0 (- (. cursor 3) 1)))
     (. cursor 4)]))
(fn replace-tabs [s]
  "replace tabs with <space> * #tabstop. `vim.lsp` seems to think this is okay so i guess it is"
  (string.gsub s "\t" (string.rep " " (vim.lsp.util.get_effective_tabstop))))

; {{{ (fn set-cursor-old [])
; not exactly sure what to do with this yet, the vimscript version has
; some weird logic going on. <plugin/parinfer.vim:150>
; nvim_win_set_cursor() is (1, 0) indexed
; (fn set-cursor-viml [pos] ; TODO
;   "sets cursor position, (0, 0) indexed"
;   (let
;     [cursor [(+ 1 (. pos 1)) (+ 1 (. pos 2))]
;      line (getline (. cursor 1))
;      head (matchstr line (.. ".\\+\\%<" (+ 1 (. cursor 2)) "v"))
;      col (+ 1 (string.len head))]
;     (setpos "." [(. cursor 1) col])))
; (fn set-cursor [pos]
;   "sets cursor position, (0, 0) indexed"
;   (-> (vim.fn.getline (. pos 1))
;       (vim.fn.matchstr (.. ".\\+\\%<" (. pos 2) "v"))
;       (string.len)
;       (+ 1)))
;}}}
