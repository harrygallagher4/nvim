(module dotfiles.module.indentline
  {require {a aniseed.core
            packer packer}
   require-macros [dotfiles.macros]})

(def- gs
  {:char "│"
   :viewport_buffer 30
   :use_treesitter true
   :show_current_context true
   :context_patterns
   ["class" "function" "method" "^if" "^while" "^for" "^object" "^table"
    "block" "arguments" "^attrset$" "^list$" "^let$" "^indented_string$"]
   :filetype_exclude
   ["" "help" "fennel" "packer" "lspinfo" "tsplayground" "query" "scheme" "Trouble"]
   :buftype_exclude
   ["terminal" "prompt"]})
(each [k v (pairs gs)] (tset vim.g (.. :indent_blankline_ k) v))

(tset vim.o :list true)
(tset vim.o :listchars (table.concat ["eol:↴" "tab:  " "trail:⋅" "nbsp:_"] ","))

(packer.loader "indent-blankline.nvim")

