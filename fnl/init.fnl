(module init
    {require {core aniseed.core
              util dotfiles.util
              lualine lualine}})

(global dotfiles {:module {}})

(require :astronauta.keymap)

(nvim.ex.set :termguicolors)

(def- lualine-opts
  {:options {:component_separators ["" ""]
             :disabled_filetypes ["Trouble"]
             :icons_enabled true
             :section_separators ["" ""]
             :theme "tokyonight"}
   :sections {:lualine_a ["mode"]
              :lualine_b ["branch"]
              :lualine_c ["filename"]
              :lualine_x ["encoding" {1 "fileformat" :icons_enabled false} "filetype"]
              :lualine_y ["progress"]
              :lualine_z ["location"]}
   :inactive_sections {:lualine_a {}
                       :lualine_b {}
                       :lualine_c ["filename"]
                       :lualine_x ["location"]
                       :lualine_y {}
                       :lualine_z {}}})

(do
  (tset vim.g :tokyonight_style "day")
  (nvim.ex.colorscheme "tokyonight")
  (lualine.setup lualine-opts))

  ; (lualine.setup
  ;   {:options
  ;    {:theme "tokyonight"
; ;      :component_separators ["" ""]
  ;     :component_separators ["" ""]
  ;     :section_separators ["" ""]}}))


(comment
  (do
    (tset vim.g :material_style "deep ocean")
    (tset vim.g :material_contrast true)
    ((. (require "material") :set))
    (lualine.setup {:options
                    {:theme "material-nvim"}})))
; (lualine.setup {:options
;                 {:theme "material-nvim"
;                  :icons_enabled true
;                  :component_separators ["" ""]
;                  :section_separators ["" ""]
;                  :disabled_filetypes []}
;                 :sections
;                 {:lualine_a ["mode"]
;                  :lualine_b ["branch"]
;                  :lualine_c ["filename"]
;                  :lualine_x ["encoding" "fileformat" "filetype"]
;                  :lualine_y ["progress"]
;                  :lualine_z ["location"]}
;                 :inactive_sections
;                 {:lualine_a []
;                  :lualine_b []
;                  :lualine_c ["filename"]
;                  :lualine_x ["location"]
;                  :lualine_y []
;                  :lualine_z []}
;                 :tabline {}
;                 :extensions {}})
; ((require "lush") (require "harryg.colorscheme"))

;; Load all modules in no particular order.
; (->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
;      (core.run! #(require (string.gsub $ ".*/(.-)/(.-)/(.-)%.lua" "%1.%2.%3"))))

(->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
     (core.run!
       #(let [(i j f) (string.match $ ".*/(.-)/(.-)/(.-)%.lua")
              mod (require (string.format "%s.%s.%s" i j f))]
          (tset _G.dotfiles.module f mod))))

;(def statusline (require "evilline"))

