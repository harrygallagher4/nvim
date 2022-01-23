(module dotfiles.module.lf
  {require {a aniseed.core}})

(a.assoc-in vim.g [:lf#replace_netrw] 1)

(a.assoc-in
    vim.g [:lf#layout]
    {:window
     {:width 0.85
      :height 0.85
      :highlight "TelescopeBorder"
      :border "rounded"}})

*module*

