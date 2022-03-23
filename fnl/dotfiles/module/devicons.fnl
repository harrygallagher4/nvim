(module dotfiles.module.devicons
  {require
   {devicons nvim-web-devicons}})

(local fnl-custom {:icon "" :color "#e6b439" :name "fennel"})
(local fnl-alt    {:icon "" :color "#7bc45c" :name "fennel"}) ; found this in someone's dotfiles

(devicons.setup
  {:default true
   :override {:fnl fnl-custom
              :fennel fnl-custom}})

