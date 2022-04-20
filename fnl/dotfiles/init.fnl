(module dotfiles
  {autoload
   {cmds dotfiles.commands}})

(fn require* [mod] (pcall require mod))
(fn init-module [mod] (require* (.. "dotfiles.module." mod)))

;; this goes here because if there's an error during startup I want to
;; be able to recompile
(vim.api.nvim_create_user_command
  :AniseedCompile
  #((. (require :dotfiles.compile) :aniseed-compile!))
  {})

(require* :dotfiles.options)
(require* :dotfiles.maps)
(require* :dotfiles.colorscheme)
(require* :dotfiles.ftplugin)

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
(init-module :indentline)
(init-module :neoformat)
(init-module :neorg)
(init-module :toggleterm)
(init-module :presence)
(init-module :conjure)

; parinfer needs to be required & setup after VimEnter so that
; :packadd! won't source plugin/* scripts. this way parinfer-rust is
; added to the runtimepath but isn't set up
(fn init-post []
  (init-module :vimenter)
  (cmds.enter-cmds!))

(vim.api.nvim_create_augroup "dotfiles" {:clear true})
(vim.api.nvim_create_autocmd :VimEnter {:callback init-post :group "dotfiles"})

