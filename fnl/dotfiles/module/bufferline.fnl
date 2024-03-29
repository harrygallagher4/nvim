(module dotfiles.module.bufferline
  {require
   {maps dotfiles.maps
    bufferline bufferline}})

(defn- numbers [{: id : ordinal : lower : raise}]
  (match (vim.fn.bufwinnr id)
    -1 (string.format "%s" id)
    nr (string.format "%s%s" (raise id) (lower nr))))

(bufferline.setup
  {:options
   {:diagnostics "nvim_lsp"
    :numbers numbers
    :separator_style "thick"}})

(maps :n
  [["<a-i>" "<cmd>BufferLineCycleNext<cr>"]
   ["<a-o>" "<cmd>BufferLineCyclePrev<cr>"]
   ["<c-q>" "<cmd>BufferLinePickClose<cr>"]])

