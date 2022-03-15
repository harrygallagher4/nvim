(module dotfiles
  {autoload
   {cmds dotfiles.commands
    parinfer dotfiles.scratch.parinfer}})

(defn- init-module [mod]
  (require (.. "dotfiles.module." mod)))

(require :dotfiles.options)
(require :dotfiles.maps)
(require :dotfiles.theme)
(require :dotfiles.ftplugin)

(init-module :cursorhold)

; override vim.notify. I figure this should be first in case a plugin
; wants to send a notification during startup
(init-module :notify)

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
(init-module :gitsigns)
(init-module :indentline)
(init-module :lf)
(init-module :neoformat)
(init-module :neorg)
(init-module :toggleterm)
(init-module :presence)
(init-module :conjure)

; parinfer needs to be required & setup after VimEnter so that
; :packadd! won't source plugin/* scripts. this way parinfer-rust is
; added to the runtimepath but isn't set up
(defn init-post []
  (parinfer.setup!)
  (cmds.mod-cmd! :FnlClean :dotfiles.compile :clean!)
  (cmds.mod-cmd! :FnlCompileAll :dotfiles.compile :compile-all!)
  (cmds.mod-cmd! :AniseedCompile :dotfiles.compile :aniseed-compile!))

(vim.api.nvim_create_augroup "dotfiles" {:clear true})
(vim.api.nvim_create_autocmd :VimEnter {:callback init-post :group "dotfiles"})

