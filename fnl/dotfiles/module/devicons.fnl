(module dotfiles.module.devicons
  {require {devicons nvim-web-devicons}})

(def- fnl-custom {:icon "" :color "#e6b439" :name "fennel"})
(def- fnl-alt    {:icon "" :color "#7bc45c" :name "fennel"}) ; found this in someone's dotfiles

(defn setup-devicons []
  (devicons.setup
    {:default true
     :override {:fnl fnl-custom
                :fennel fnl-custom}}))
(setup-devicons)
(tset _G :fix_devicons setup-devicons)

