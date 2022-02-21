(module dotfiles.module.neorg
  {require {a aniseed.core
            : neorg
            dfts dotfiles.module.treesitter}})

(neorg.setup
  {:load
   {:core.defaults {}
    :core.neorgcmd {}

    :core.norg.concealer
    {:config
     {:icon_preset "diamond"
      :markup_preset "dimmed"}} ; "brave" hides markup characters

    :core.keybinds
    {:config {:default_keybinds true}}

    :core.norg.dirman
    {:config
     {:workspaces
      {:main "~/Documents/neorg"
       :home "~/neorg"
       :gtd "~/Documents/neorg/gtd"}
      :autochdir false
      :autodetect false}}

    :core.integrations.telescope {}

    :core.gtd.base
    {:config {:workspace "gtd"}}}})


    ; :core.neorgcmd {}
