(module dotfiles.module.lsp
  {require {a aniseed.core
            nvim aniseed.nvim
            lsp lspconfig
            lspstatus lsp-status
            saga lspsaga
            trouble trouble}
   require-macros [dotfiles.maps.macros]})

(def- lua-runtime-path
  (a.concat
    ["lua/?.lua" "lua/?/init.lua"]
    (vim.split package.path ";")))

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

; (setup :rnix        {: on_attach})
(setup :svelte      {: on_attach})
(setup :denols      {: on_attach})
(setup :tsserver    {: on_attach})
(setup :clojure_lsp {: on_attach})
(setup :jsonls      {: on_attach})
(setup :bashls      {: on_attach})
(setup :yamlls      {: on_attach})
(setup :vimls       {: on_attach})
(setup :sumneko_lua
       {: on_attach
        :settings
        {:Lua
         {:runtime {:version "LuaJIT" :path lua-runtime-path}
          :diagnostics {:globals ["vim"]}
          :workspace {:library (vim.api.nvim_get_runtime_file "" true)}
          :telemetry {:enable false}}}})

