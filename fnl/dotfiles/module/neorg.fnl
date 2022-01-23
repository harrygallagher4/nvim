(module dotfiles.module.neorg
  {require {a aniseed.core
            : neorg
            dfts dotfiles.module.treesitter}})

(neorg.setup
  {:load
   {:core.defaults {}
    :core.neorgcmd {}
    :core.integrations.telescope {}
    :core.norg.concealer
    {:config
     {:icon_preset "diamond"
      :markup_preset "dimmed"}} ; "brave" hides markup characters
    :core.norg.dirman
    {:config
     {:workspaces
      {:home "~/neorg"}}}}})

*module*

