(module dotfiles.module.neorg
  {require
   {neorg neorg
    dfts dotfiles.module.treesitter}
   require-macros [dotfiles.macros]})

(neorg.setup
  {:load {:core.defaults {}

          :core.norg.completion {:config {:engine "nvim-cmp"}}

          :core.neorgcmd {}

          :core.norg.concealer {:config {:icon_preset "diamond"
                                         :markup_preset "conceal"}}

          :core.keybinds {:config {:default_keybinds true
                                   :hook #(apply-all
                                            ($.remap_key "norg" "n")
                                            ("<C-Space>" "<localleader>t")
                                            ("gtp" "<localleader>gp")
                                            ("gtr" "<localleader>gr")
                                            ("gti" "<localleader>gi")
                                            ("gtd" "<localleader>gd")
                                            ("gth" "<localleader>gh")
                                            ("gtc" "<localleader>gc")
                                            ("gtu" "<localleader>gu"))}}

          :core.norg.dirman {:config {:workspaces {:home "~/neorg"
                                                   :gtd "~/Documents/neorg/gtd"}
                                      :autochdir false
                                      :autodetect false}}

          :core.norg.journal {:config {:workspace "home"}}

          :core.norg.qol.toc {}

          :core.integrations.telescope {}

          :core.gtd.base {:config {:workspace "gtd"}}}})

