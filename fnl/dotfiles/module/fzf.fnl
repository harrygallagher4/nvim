(module dotfiles.module.fzf
  {require {a aniseed.core}})

(set vim.g.fzf_layout
     {:window
      {:width 0.9
       :height 0.6
       :highlight "VertSplit"
       :border "sharp"}})

(set vim.g.fzf_action
     {:ctrl-i :vsplit
      :ctrl-o :split})

*module*

