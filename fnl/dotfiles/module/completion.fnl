(module dotfiles.module.completion
  {require
   {a aniseed.core
    lspkind lspkind
    ls luasnip
    cmp cmp
    ctx cmp.config.context}})

(lspkind.init {})

(def- m cmp.mapping)
(def- s cmp.config.sources)
(def- expandable? ls.expandable)
(def- expandable-or-jumpable? ls.expand_or_jumpable)
(defn- expandable-and-not-selected? []
  (and (expandable?) (a.nil? (cmp.get_selected_entry))))
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
  {:formatting
   {:format (lspkind.cmp_format)}

   :snippet
   {:expand (fn [{: body}] (ls.lsp_expand body))}

   :sources
   (s [{:name "nvim_lsp"}
       {:name "path" :trigger_characters ["/"]}]
      [{:name "buffer"}])

   ; wonder if this slows down cmp?
   :enabled
   #(if (= "c" (. (vim.api.nvim_get_mode) :mode)) true
        (and (not (ctx.in_treesitter_capture "comment"))
             (not (ctx.in_syntax_group "Comment"))))

   :mapping
   {:<c-space> (m (m.complete) [:i :c])
    :<c-e>     (m {:i (m.abort) :c (m.close)})
    :<c-p>     (m (m.scroll_docs -4) [:i :c])
    :<c-n>     (m (m.scroll_docs 4) [:i :c])
    :<cr>      (m.confirm {:select true})
    :<esc>     (m #(if (visible?) (cmp.abort) ($)) [:i :c])
    :<tab>     (m #(if (expandable-and-not-selected?) (ls.expand)
                       (visible?) (cmp.select_next_item)
                       (expandable-or-jumpable?) (ls.expand_or_jump)
                       (has-word-before?) (cmp.complete)
                       ($)) [:i :s])
    :<s-tab>   (m #(if (visible?) (cmp.select_prev_item)
                       (backwards-jumpable?) (ls.jump -1)
                       ($)) [:i :s])}})

(cmp.setup.filetype
  "fennel"
  {:sources
   (s [{:name "conjure"}
       {:name "buffer"}
       {:name "path" :trigger_characters ["/"]}])})

(cmp.setup.filetype
  "norg"
  {:sources
   (s [{:name "neorg"}])})

; complete from buffer when searching
(cmp.setup.cmdline "/" {:sources [{:name "buffer"}]})
(cmp.setup.cmdline ":" {:sources (s [{:name "path"}] [{:name "cmdline"}])})

