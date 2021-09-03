(module dotfiles.module.lf
  {require {a aniseed.core
            nvim aniseed.nvim}
   require-macros [dotfiles.macros]})

(def mod :lf)

(a.assoc-in vim.g [:lf#replace_netrw] 1)

(a.assoc-in
    vim.g [:lf#layout]
    {:window
     {:width 0.85
      :height 0.85
      :highlight "TelescopeBorder"
      :border "rounded"}})

; (vim.fn.expand "%:h")
; (nvim.ex.cd "%:h")

; :set ratios 4:6:8

