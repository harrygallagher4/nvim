(module dotfiles.module.bufferline
  {require {maps dotfiles.maps
            bufferline bufferline}})

(defn- numbers [{:id id :ordinal ordinal :lower lower :raise raise}]
  (let [winnr (vim.fn.bufwinnr id)]
    (if (= -1 winnr)
        (string.format "%s" id)
        (string.format "%s%s" (raise id) (lower winnr)))))

(bufferline.setup
  {:options
   {:diagnostics "nvim_lsp"
    :numbers numbers
    :separator_style "thick"}})

(maps.map-multi :n
  [["<leader>]" "<cmd>BufferLineCycleNext<cr>"]
   ["<leader>[" "<cmd>BufferLineCyclePrev<cr>"]
   ["<leader><leader>o" "<cmd>BufferLinePick<cr>"]])

*module*

