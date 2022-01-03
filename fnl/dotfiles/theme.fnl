(module dotfiles.theme
  {require {a aniseed.core
            lualine lualine}
   require-macros [dotfiles.macros]})

(tset vim.g :tokyonight_style "storm")
; (tset vim.g :tokyonight_day_brightness 0.275)
(tset vim.g :material_style "deep ocean")
(tset vim.g :material_contrast true)

(def- theme (or vim.g.theme "tokyonight"))

(def- lualine-themes
  {:none "none"})
(defn- lualine-theme [theme]
  (or (. lualine-themes theme) theme))
(defn- lualine-opts [theme]
  {:options {:component_separators ["" ""]
             :disabled_filetypes ["Trouble"]
             :icons_enabled true
             :section_separators {:left "" :right ""}
             :theme (lualine-theme theme)}
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

(defn init [theme]
  (nvim.ex.set :termguicolors)
  (nvim.ex.colorscheme "tokyonight")
  (lualine.setup (lualine-opts theme)))

