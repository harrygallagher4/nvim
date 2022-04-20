(module dotfiles.module.vimenter
  {autoload
   {: parinfer
    : specs
    : gitsigns}})

;; this module is for loading things on VimEnter.
;; not specifically for performance but just for
;; unimportant/trivial setups

(parinfer.setup {:trail_highlight false})

(local gitsigns_disabled_filetypes ["norg"])
(gitsigns.setup {:on_attach (fn [buf]
                              (if (vim.tbl_contains
                                    gitsigns_disabled_filetypes
                                    vim.bo.filetype)
                                  false))})

(specs.setup {:popup {:blend 10
                      :inc 3
                      :width 24
                      :winhl "lualine_a_insert"
                      :resizer specs.shrink_resizer
                      :fader specs.linear_fader}
              :ignore_buftypes {:nofile true
                                :nowrite true
                                :quickfix true
                                :terminal true
                                :prompt true}
              :ignore_filetypes {:TelescopePrompt true
                                 :Trouble true}})

(tset vim.g :lf#replace_netrw 1)
(tset vim.g :lf#layout {:window {:width 0.85
                                 :height 0.85
                                 :highlight "TelescopeBorder"
                                 :border "rounded"}})

(tset vim.g :fzf_layout {:window {:width 0.9
                                  :height 0.6
                                  :highlight "VertSplit"
                                  :border "sharp"}})

(tset vim.g :fzf_action {:ctrl-i :vsplit
                         :ctrl-o :split})

