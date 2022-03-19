(module dotfiles.module.lsp
  {require {a aniseed.core
            lsp lspconfig
            cmp-lsp cmp_nvim_lsp
            trouble trouble
            completion dotfiles.module.completion
            fidget dotfiles.module.fidget
            maps dotfiles.maps}
   require-macros [dotfiles.maps.macros]})

(def- lua-runtime-path
  (a.concat
    ["lua/?.lua" "lua/?/init.lua"]
    (vim.split package.path ";")))

(def- capabilities
  (cmp-lsp.update_capabilities (vim.lsp.protocol.make_client_capabilities)))

(trouble.setup
  {:auto_preview false
   :padding false
   :height 8
   :action_keys {:previous {} :next {}}})

(defn on-attach [client buf]
  (maps.map-multi :n
    [[:K vim.lsp.buf.hover {:buffer buf}]
     [:<c-l> vim.lsp.buf.signature_help {:buffer buf}]
     [:gd vim.lsp.buf.definition {:buffer buf}]
     [:gr vim.lsp.buf.references {:buffer buf}]
     [:gD vim.lsp.buf.declaration {:buffer buf}]
     [:gi vim.lsp.buf.implementation {:buffer buf}]
     [:<leader>r vim.lsp.buf.rename {:buffer buf}]
     [:<leader>ca vim.lsp.buf.code_action {:buffer buf}]
     [:<leader>d #(vim.diagnostic.show nil buf) {:buffer buf}]
     ["[d" vim.diagnostic.goto_next {:buffer buf}]
     ["]d" vim.diagnostic.goto_next {:buffer buf}]])
     ; "<rbracket>d" vim.diagnostic.toqflist {:buffer buf}
  (maps.map [:i :<c-l> vim.lsp.buf.signature_help {:buffer buf}])
  (when client.resolved_capabilities.document_formatting
    (maps.map [:n :<leader>f vim.lsp.buf.formatting {:buffer buf}]))
  (when client.resolved_capabilities.document_range_formatting
    (maps.map [:v :<leader>f vim.lsp.buf.range_formatting {:buffer buf}])))

(defn- setup [server config]
  (let [default-config {: capabilities :on_attach on-attach}]
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

