(module dotfiles.module.lsp
  {require {a aniseed.core
            nvim aniseed.nvim
            lsp lspconfig
            configs :lspconfig/configs
            util :lspconfig/util
            lspstatus lsp-status
            lualsp dotfiles.util.lualsp
            saga lspsaga
            navigator navigator
            lspsig lsp_signature
            trouble trouble}
   require-macros [dotfiles.macros
                   dotfiles.maps.macros]})

; (navigator.setup
;   {:border "none"
;    :default_mapping false
;    :lsp {:sumneko_lua
;          {:cmd lualsp.cmd
;           :sumneko_root_path lualsp.sumneko-root
;           :sumneko_binary lualsp.bin}}})

; (navigator.setup
;   {:border "none"
;    :default_mapping false
;    :lsp {:sumneko_lua (lualsp.setup)}})

(trouble.setup
  {:auto_preview false
   :height 8})

(defn- on_attach [client]
  (lspstatus.on_attach client)
  (nnoremap :K            vim.lsp.buf.hover                         :buffer true)
  (nnoremap :<c-l>        vim.lsp.buf.signature_help                :buffer true)
  (inoremap :<c-l>        vim.lsp.buf.signature_help                :buffer true)
  (nnoremap :gd           vim.lsp.buf.definition                    :buffer true)
  (nnoremap :gr           vim.lsp.buf.references                    :buffer true)
  (nnoremap :gD           vim.lsp.buf.declaration                   :buffer true)
  (nnoremap :gi           vim.lsp.buf.implementation                :buffer true)
  (nnoremap :<leader>r    vim.lsp.buf.rename                        :buffer true)
  (nnoremap :<leader>ca   vim.lsp.buf.code_action                   :buffer true)
  (nnoremap :<leader>d    vim.lsp.diagnostic.show_line_diagnostics  :buffer true)
  (nnoremap "[d"          vim.lsp.diagnostic.goto_prev              :buffer true)
  (nnoremap "d]"          vim.lsp.diagnostic.goto_next              :buffer true)
  (nnoremap :<leader>q    vim.lsp.diagnostic.set_loclist            :buffer true)
  (when client.resolved_capabilities.document_formatting
    (nnoremap :<leader>f  vim.lsp.buf.formatting                    :buffer true))
  (when client.resolved_capabilities.document_range_formatting
    (vnoremap :<leader>f  vim.lsp.buf.range_formatting              :buffer true)))

(defn- setup [server config]
  ((a.get-in lsp [server :setup]) config))

;
; set things up
; =============

(lspstatus.register_progress)
(saga.init_lsp_saga)

; (set configs.neuron_ls
;      {:default_config
;       {:cmd ["neuron-language-server"]
;        :filetypes ["markdown"]
;        :root_dir (util.root_pattern ".neuron")
;        :settings {}}})

;(setup :neuron_ls   {: on_attach})
(setup :rnix        {: on_attach})
(setup :svelte      {: on_attach})
(setup :denols      {: on_attach})
(setup :tsserver    {: on_attach})
(setup :clojure_lsp {: on_attach})
(setup :jsonls      {: on_attach})
(setup :bashls      {: on_attach})
(setup :yamlls      {: on_attach})
(setup :vimls       {: on_attach})
(setup :sumneko_lua (lualsp.setup {: on_attach}))
; (setup :sumneko_lua (lualsp.config {: on_attach}))

;
; using lspsaga.nvim:
;
; (defn- on_attach [client]
;   (lspstatus.on_attach client)
;   (nnoremap :K            lsphover.render_hover_doc                 :buffer true)
;   (nnoremap :<c-l>        signature.signature_help                  :buffer true)
;   (inoremap :<c-l>        signature.signature_help                  :buffer true)
;   (nnoremap :gd           vim.lsp.buf.definition                    :buffer true)
;   (nnoremap :gr           vim.lsp.buf.references                    :buffer true)
;   (nnoremap :gD           vim.lsp.buf.declaration                   :buffer true)
;   (nnoremap :gi           vim.lsp.buf.implementation                :buffer true)
;   (nnoremap :<leader>r    lsprename.rename                          :buffer true)
;   (nnoremap :<leader>ca   codeaction.code_action                    :buffer true)
;   (nnoremap :<leader>d    diagnostic.show_line_diagnostics          :buffer true)
;   (nnoremap "[d"          diagnostic.lsp_jump_diagnostic_prev       :buffer true)
;   (nnoremap "d]"          diagnostic.lsp_jump_diagnostic_next       :buffer true)
;   (nnoremap :<leader>q    vim.lsp.diagnostic.set_loclist            :buffer true)
;   (when client.resolved_capabilities.document_formatting
;     (nnoremap :<leader>f  vim.lsp.buf.formatting                    :buffer true))
;   (when client.resolved_capabilities.document_range_formatting
;     (vnoremap :<leader>f  vim.lsp.buf.range_formatting              :buffer true)))

