(module dotfiles.init)

(defn- init-module [mod]
  (require (.. "dotfiles.module." mod)))

(require :dotfiles.options)
(require :dotfiles.maps)
(require :dotfiles.theme)

(init-module :devicons)
(init-module :bufferline)
(init-module :lsp)
(init-module :snippets)
(init-module :completion)
(init-module :treesitter)
(init-module :telescope)
(init-module :neorg)
(init-module :indentline)
(init-module :toggleterm)
(init-module :lf)

(defn init_post [])

(vim.cmd
  " augroup dotfiles
    autocmd!
    autocmd VimEnter * lua require'dotfiles.init'.init_post()
    augroup END")

*module*

; (defn- init-all-modules []
;   (when (not _G.dotfiles) (tset _G :dotfiles []))
;   (->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
;        (a.run!
;          #(let [(i j f) (string.match $ ".*/(.-)/(.-)/(.-)%.lua")
;                 mod (require (string.format "%s.%s.%s" i j f))]
;             (tset _G.dotfiles.module f mod)))))

