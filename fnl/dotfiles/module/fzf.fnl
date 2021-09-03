(module dotfiles.module.fzf
  {require {a aniseed.core
            nvim aniseed.nvim}})

(set nvim.g.fzf_layout
     {:window
      {:width 0.9
       :height 0.6
       :highlight "VertSplit"
       :border "sharp"}})

(set nvim.g.fzf_action
     {:ctrl-i :vsplit
      :ctrl-o :split})

