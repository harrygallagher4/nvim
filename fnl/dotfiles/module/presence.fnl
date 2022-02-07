(module dotfiles.module.presence
  {require {a aniseed.core
            : presence}})

(defn setup [...]
  (: presence :setup ...))

(setup
  {:auto_update true
   :main_image "neovim" ; or "file"
   :buttons true
   :blacklist []})

