(module dotfiles.module.completion
  {require {a aniseed.core
            lspkind lspkind
            cmp cmp
            ls luasnip}
   require-macros [dotfiles.maps.macros]})

(set vim.o.completeopt "menu,menuone,noselect")
(lspkind.init {})

(def- m cmp.mapping)
(def- s cmp.config.sources)
(def- expandable-or-jumpable? ls.expand_or_jumpable)
(defn- backwards-jumpable? [] (ls.jumpable -1))
(def- visible? cmp.visible)
(defn- has-word-before? []
  (let [[line col] (vim.api.nvim_win_get_cursor 0)
        [s] (vim.api.nvim_buf_get_lines 0 (- line 1) line true)]
    (and (~= col 0)
         (-> s
             (string.sub col col)
             (string.match "%s")
             (a.nil?)))))

(cmp.setup
  {:experimental
   {:native_menu false
    :ghost_text true}

   :formatting
   {:format (lspkind.cmp_format)}

   :snippet
   {:expand
    (fn [{: body}] (ls.lsp_expand body))}

   :sources
   (s [{:name "nvim_lsp"}
       {:name "conjure"}
       {:name "luasnip"}]
      [{:name "buffer"}])

   :mapping
   {:<c-space> (m (m.complete) [:i :c])
    :<c-e>     (m {:i (m.abort) :c (m.close)})
    :<c-p>     (m (m.scroll_docs -4) [:i :c])
    :<c-n>     (m (m.scroll_docs 4) [:i :c])
    :<cr>      (m.confirm {:select true})
    :<tab>
    (m (fn [fallback]
         (if (visible?) (cmp.select_next_item)
             (expandable-or-jumpable?) (ls.expand_or_jump)
             (has-word-before?) (cmp.complete)
             (fallback))))
    :<s-tab>
    (m (fn [fallback]
         (if (visible?) (cmp.select_prev_item)
             (backwards-jumpable?) (ls.jump -1)
             (fallback))))}})

; complete from buffer when searching
(cmp.setup.cmdline "/" {:sources [{:name "buffer"}]})
(cmp.setup.cmdline ":" {:sources (cmp.config.sources [{:name "path"}] [{:name "cmdline"}])})

