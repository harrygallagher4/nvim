(module dotfiles)

(defn- init-module [mod]
  (require (.. "dotfiles.module." mod)))

(require :dotfiles.options)
(require :dotfiles.maps)
(require :dotfiles.theme)

; TODO: decide if I should replace explicit
; module load-order with the old require-all
; method. Modules that need to be loaded
; after another can be handled by requiring
; the earlier module from the later one
(init-module :devicons)
(init-module :bufferline)
(init-module :lsp)
(init-module :snippets)
(init-module :completion)
(init-module :treesitter)
(init-module :telescope)
; order doesn't matter
(init-module :conjure)
(init-module :gitsigns)
(init-module :indentline)
(init-module :lf)
(init-module :neoformat)
(init-module :neorg)
(init-module :toggleterm)

(defn init_post [])

(vim.cmd
  " augroup dotfiles
    autocmd!
    autocmd VimEnter * lua require'dotfiles'.init_post()
    augroup END")

; (let [wrap-module
;       (macro wrap-module [...]
;         (let [body# [...]
;               last-expr# (table.remove body#)]
;           (table.insert body#
;             `(let [original-return# (do ,last-expr#)]
;                (or ,(sym "*module*") original-return#)))
;           `(do ,(unpack body#))))]
;   (macrodebug (wrap-module (print "test1") (print "test2") {:x 1})))

; (defn- init-all-modules []
;   (when (not _G.dotfiles) (tset _G :dotfiles []))
;   (->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
;        (a.run!
;          #(let [(i j f) (string.match $ ".*/(.-)/(.-)/(.-)%.lua")
;                 mod (require (string.format "%s.%s.%s" i j f))]
;             (tset _G.dotfiles.module f mod)))))

