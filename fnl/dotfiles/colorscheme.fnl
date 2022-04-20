(module dotfiles.colorscheme
  {require {: catppuccin
            catapi catppuccin.api.colors}
   autoload {: lualine : feline}})

(local slp :lualine)


(catppuccin.setup {:term_colors true
                   :styles {:comments "italic" ; italic
                            :functions "italic" ; italic
                            :keywords "italic" ; italic
                            :strings "NONE" ; NONE
                            :variables "italic"} ; italic
                   :integrations {:bufferline true
                                  :cmp true
                                  :gitsigns true
                                  :lightspeed false
                                  :lsp_saga true
                                  :lsp_trouble true
                                  :notify true
                                  :telescope true
                                  :ts_rainbow true
                                  :which_key true
                                  :indent_blankline {:enabled true}}})

(local cp (catapi.get_colors))
(catppuccin.remap {:BufferLineBackground {:fg cp.gray0}
                   :BufferLineBufferSelected {:fg cp.gray2}
                   :BufferLineNumbersSelected {:fg cp.gray2}})

(catppuccin.load)



(when (= slp :feline)
  (feline.setup))



(when (= slp :lualine)
  (lualine.setup {:options {:theme "catppuccin"
                            :icons_enabled true
                            :component_separators ""
                            :section_separators ""
                            :disabled_filetypes ["Trouble" "toggleterm"]}
                  :sections {:lualine_a ["mode"]
                             :lualine_b ["branch"]
                             :lualine_c ["filename"]
                             :lualine_x ["diff"
                                         "encoding"
                                         {1 "fileformat"
                                          :icons_enabled false}
                                         "filetype"]
                             :lualine_y ["progress"]
                             :lualine_z ["location"]}
                  :inactive_sections {:lualine_a {}
                                      :lualine_b {}
                                      :lualine_c ["filename"]
                                      :lualine_x []
                                      :lualine_y {}
                                      :lualine_z {}}}))

