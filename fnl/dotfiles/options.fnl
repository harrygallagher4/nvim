(module dotfiles.options
  {require {a aniseed.core}})

(defn gset [varname value]
  (tset vim.g varname value))

(defn oset [optname value]
  (let [v (if (a.nil? value) true value)]
    (tset vim.opt optname v)))

(defn oset+ [optname value]
  (: (. vim.opt optname) :append value))



(gset :loaded_python_provider 0)
(gset :python3_host_prog "/usr/local/bin/python3")
(gset :node_host_prog "/Users/harry/.config/yarn/global/node_modules/neovim/bin/cli.js")
(gset :cursorhold_updatetime 100)

(gset :mapleader " ")

(oset :termguicolors true)

(when (or (= 1 vim.g.uivonim) (= 1 vim.g.goneovim))
  (oset :guifont "Iosevka Nerd Font:h15")
  (oset :linespace 3))

(oset :encoding "utf8")

(oset :backupdir (.. (vim.fn.stdpath "data") "/backup"))
(oset :directory (.. (vim.fn.stdpath "data") "/swap"))
(oset :undodir   (.. (vim.fn.stdpath "data") "/undo"))
(oset :undofile)
(oset :backup false)
(oset :writebackup)

(oset :autoread)
(oset :backspace [:indent :eol :start])
(oset :cursorline)
(oset :cursorlineopt "number")
(oset :fillchars {:eob " "})
(oset :hidden)
(oset :hlsearch)
(oset :ignorecase)
(oset :incsearch)
(oset :inccommand "nosplit")
(oset :linebreak)
(oset :list)
(oset :listchars {:eol "↴" :tab "  " :trail "⋅" :nbsp "_"})
(oset :mouse "a")
(oset :equalalways false)
(oset :wrap false)
(oset :number)
(oset :numberwidth 3)
(oset :pumheight 8)
(oset :scrolloff 3)
(oset :showcmd)
(oset :signcolumn "auto")
(oset :smartcase)
(oset :smarttab)
(oset :splitbelow)
(oset :splitright)
(oset :virtualedit [:block])
(oset :wildmenu)
(oset :wildmode [:longest :full])
(oset :wildoptions "pum")

; (oset :foldlevelstart 99)
; (oset :foldmethod "expr")
; (oset :foldexpr ((. vim.fn "nvim_treesitter#foldexpr")))

(oset :completeopt [:menu :menuone :noinsert :noselect])
(oset+ :shortmess :c)

(set vim.env.FZF_DEFAULT_OPTS (.. vim.env.FZF_DEFAULT_OPTS " --margin=0,0"))

*module*

