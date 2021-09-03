(module dotfiles.module.completion
  {require {a aniseed.core
            nvim aniseed.nvim
            lspkind lspkind
            compe compe
            ls luasnip}
   require-macros [dotfiles.maps.macros]})
(set nvim.o.completeopt "menuone,noselect")

(lspkind.init {})

(compe.setup
  {:enabled true
   :autocomplete true
   :debug false
   :min_length 1
   :preselect "enable"
   :throttle_time 80
   :source_timeout 200
   :incomplete_delay 400
   :max_abbr_width 100
   :max_kind_width 100
   :max_menu_width 100
   :documentation true

   :source
   {:path true
    :buffer {:dup false}
    :calc false
    :omni false
    :vsnip false
    :nvim_lsp true
    :nvim_lua true
    :spell false
    :tags false
    :snippets_nvim false
    :treesitter false
    :conjure true
    :luasnip true
    :neorg true}})

(def- compe-complete (. vim.fn :compe#complete))

(defn- check-back-space []
  (let [col (- (vim.fn.col ".") 1)]
    (if (or (= 0 col) (-> (vim.fn.getline ".")
                          (: :sub col col)
                          (: :match "%s")))
      true false)))

(defn- tab-complete []
  (if
    (= 1 (vim.fn.pumvisible))
    (tc "<c-n>")
    (ls.jumpable)
    (tc "<Plug>luasnip-jump-next")
    (ls.expand_or_jumpable)
    (tc "<Plug>luasnip-expand-or-jump")
    (check-back-space)
    (tc "<tab>")
    (compe-complete)))

(defn- shift-tab-complete []
  (if
    (= 1 (vim.fn.pumvisible))
    (tc "<c-p>")
    (ls.jumpable -1)
    (tc "<plug>luasnip-jump-prev")
    (tc "<s-tab>")))

(global map_utils
  {:tab_complete tab-complete
   :s_tab_complete shift-tab-complete})

(imap :<tab> "v:lua.map_utils.tab_complete()" :expr true)
(imap :<s-tab> "v:lua.map_utils.s_tab_complete()" :expr true)
(snoremap :<tab> "<cmd>lua require'luasnip'.jump(1)<cr>" :silent true)
(snoremap :<s-tab> "<cmd>lua require'luasnip'.jump(-1)<cr>" :silent true)

; (def- zzzzzzzzzz 0)

