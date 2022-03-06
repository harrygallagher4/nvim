
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

