(module dotfiles.module.lsp
  {require {a aniseed.core
            lsp lspconfig
            cmp-lsp cmp_nvim_lsp
            completion dotfiles.module.completion
            trouble trouble
            fidget dotfiles.module.fidget}
   require-macros [dotfiles.maps.macros]})

(def- lua-runtime-path
  (a.concat
    ["lua/?.lua" "lua/?/init.lua"]
    (vim.split package.path ";")))

(def- capabilities
  (cmp-lsp.update_capabilities (vim.lsp.protocol.make_client_capabilities)))

(trouble.setup {:auto_preview false :height 8})

(defn- on_attach [client]
  (tset vim.wo :signcolumn "yes")
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
  (let [default-config {: capabilities : on_attach}]
    ((a.get-in lsp [server :setup])
     (if (a.nil? config)
         default-config
         (vim.tbl_extend "force" default-config config)))))

;
; set things up
; =============

(fidget.setup)

; (setup :rnix        {: on_attach})
(setup :svelte)
(setup :denols)
; (setup :tsserver)
(setup :clojure_lsp)
(setup :jsonls)
(setup :bashls)
(setup :yamlls)
(setup :vimls)
(setup :sumneko_lua
       {:settings
        {:Lua
         {:runtime {:version "LuaJIT" :path lua-runtime-path}
          :diagnostics {:globals ["vim"]}
          :workspace {:library (vim.api.nvim_get_runtime_file "" true)}
          :telemetry {:enable false}}}})

