(module init
    {require {a aniseed.core
              util dotfiles.util
              theme dotfiles.theme}})

(global dotfiles {:module {}})
(require :astronauta.keymap)

(theme.init "tokyonight")

(->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
     (a.run!
       #(let [(i j f) (string.match $ ".*/(.-)/(.-)/(.-)%.lua")
              mod (require (string.format "%s.%s.%s" i j f))]
          (tset _G.dotfiles.module f mod))))

