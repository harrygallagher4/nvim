(module dotfiles.theme
  {require {util dotfiles.util
            : catppuccin}
   autoload {: lualine}})

(def- colorscheme "catppuccin")

; leaving these here just because
(tset vim.g :tokyonight_style "night")
(tset vim.g :tokyonight_day_brightness 0.275)
(tset vim.g :material_style "deep ocean")
(tset vim.g :material_contrast true)

(def- setup-fns
  {:catppuccin
   #(catppuccin.setup
      {:term_colors true
       :integrations
       {:lsp_trouble true
        :lsp_saga true
        :ts_rainbow true
        :indent_blankline {:enabled true}}})})

(defn- setup [theme]
  (let [f (. setup-fns theme)]
    (when f (f))))

; used when colorscheme and lualine theme name differ
(def- lualine-themes
  {:none "none"})
(defn- lualine-theme [theme]
  (or (. lualine-themes theme) theme))

(defn- lualine-opts [theme]
  {:options {:component_separators ["" ""]
             :disabled_filetypes ["Trouble" "toggleterm"]
             :icons_enabled true
             :section_separators {:left "" :right ""}
             :theme (lualine-theme theme)}
   :sections {:lualine_a ["mode"]
              :lualine_b ["branch"]
              :lualine_c ["filename"]
              :lualine_x ["diff"
                          "encoding"
                          {1 "fileformat" :icons_enabled false}
                          "filetype"]
              :lualine_y ["progress"]
              :lualine_z ["location"]}
   :inactive_sections {:lualine_a {}
                       :lualine_b {}
                       :lualine_c ["filename"]
                       :lualine_x ["location"]
                       :lualine_y {}
                       :lualine_z {}}})

(defn init [theme]
  (setup theme)
  (util.cmd "colorscheme %s" theme)
  (lualine.setup (lualine-opts theme)))

(init colorscheme)

*module*

