(module dotfiles.options
  {require
   {a aniseed.core
    util dotfiles.util}})

(defn gset [varname value]
  (tset vim.g varname value))

(defn oset [optname value]
  (let [v (if (a.nil? value) true value)]
    (tset vim.opt optname v)))

(defn oset+ [optname value]
  (: (. vim.opt optname) :append value))
(defn o+set [optname value]
  (: (. vim.opt optname) :prepend value))
(defn oset- [optname value]
  (: (. vim.opt optname) :remove value))


(gset :loaded_2html_plugin 1)
(gset :loaded_gzip 1)
(gset :loaded_tarPlugin 1)
(gset :loaded_tutor_mode_plugin 1)
(gset :loaded_zipPlugin 1)

(gset :loaded_python_provider 0)
(gset :python3_host_prog "/usr/local/bin/python3")
(gset :node_host_prog (util.stdfile "config" ".." "yarn/global/node_modules/neovim/bin/cli.js"))
(gset :loaded_fix_cursorhold_nvim "yes")
(gset :cursorhold_updatetime 100)
(gset :do_filetype_lua 1)
(gset :did_load_filetypes 0)

; this makes :Man look like :help
(gset :man_hardwrap true)
(tset vim.env :MANWIDTH 79)

(gset :mapleader " ")

(oset :termguicolors true)

(when (or (= 1 vim.g.uivonim) (= 1 vim.g.goneovim))
  (oset :guifont "Iosevka Nerd Font:h15")
  (oset :linespace 3))

(oset :encoding "utf8")

(oset :shada ["!" "'500" "<100" "s100" "h"])
(oset :backupdir (util.stdfile "data" "backup"))
(oset :directory (util.stdfile "data" "swap"))
(oset :undodir (util.stdfile "data" "undo"))
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
(oset :listchars {:tab "  " :trail "⋅" :nbsp "_"})
(oset :mouse "a")
(oset :equalalways false)
(oset :wrap false)
(oset :number)
(oset :numberwidth 3)
(oset :previewheight 8)
(oset :pumheight 8)
(oset :scrolloff 3)
(oset :showcmd)
(oset :signcolumn "yes:1")
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
; (oset :listchars {:eol "↴" :tab "  " :trail "⋅" :multispace "⋅" :nbsp "_"})

(oset :completeopt [:menu :menuone :noinsert :noselect])
(oset+ :shortmess :c)

(oset- :lispwords "if")
(oset+ :lispwords ["accumulate" "doto"])
(gset
  :fennel_fuzzy_indent_patterns
  ["^def" "^let" "^while" "^fn$" "^var$" "^case$" "^for$" "^each$"
   "^local$" "^global$" "^match$" "^macro" "^lambda$" "^with-open$"])

(set vim.env.FZF_DEFAULT_OPTS (.. vim.env.FZF_DEFAULT_OPTS " --margin=0,0"))

