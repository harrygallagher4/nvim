(module init
    {require {core aniseed.core
              util dotfiles.util
              theme dotfiles.theme}})

(global dotfiles {:module {}})
(require :astronauta.keymap)

(theme.init "tokyonight")

(->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
     (core.run!
       #(let [(i j f) (string.match $ ".*/(.-)/(.-)/(.-)%.lua")
              mod (require (string.format "%s.%s.%s" i j f))]
          (tset _G.dotfiles.module f mod))))

