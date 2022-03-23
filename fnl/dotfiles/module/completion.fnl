(module dotfiles.module.completion
  {require
   {lspkind lspkind
    ls luasnip
    cmp cmp
    ctx cmp.config.context}})

; this may be overkill, but I figure it couldn't hurt to cache
; functions that are going to be called very often. plus i'd consider
; completion an area where performance is important
(local (s/sub s/match) (values string.sub string.match))
(local get-mode vim.api.nvim_get_mode)
(local win-get-cursor vim.api.nvim_win_get_cursor)
(local buf-get-lines vim.api.nvim_buf_get_lines)

(local m cmp.mapping)
(local s cmp.config.sources)

(local complete! cmp.complete)
(local abort! cmp.abort)
(local select-next-item! cmp.select_next_item)
(local select-prev-item! cmp.select_prev_item)
(local jump! ls.jump)
(local expand! ls.expand)
(local lsp-expand! ls.lsp_expand)
(local expand-or-jump! ls.expand_or_jump)

(local visible? cmp.visible)
(local get-selected-entry cmp.get_selected_entry)
(local jumpable? ls.jumpable)
(local expandable? ls.expandable)
(local expandable-or-jumpable? ls.expand_or_jumpable)
(local in-treesitter-capture? ctx.in_treesitter_capture)
(local in-syntax-group? ctx.in_syntax_group)

(fn expandable-and-not-selected? []
  (and (expandable?) (= nil (get-selected-entry))))
(fn backwards-jumpable? [] (jumpable? -1))
(fn has-word-before? []
  (let [[line col] (win-get-cursor 0)
        [s] (buf-get-lines 0 (- line 1) line true)]
    (and (~= col 0)
         (-> s
             (s/sub col col)
             (s/match "%s")
             (not= nil)))))

(lspkind.init {})

(cmp.setup
  {:formatting
   {:format (lspkind.cmp_format)}

   :snippet
   {:expand (fn [{: body}] (lsp-expand! body))}

   :sources
   (s [{:name "nvim_lsp"}
       {:name "path" :trigger_characters ["/"]}]
      [{:name "buffer"}])

   ; wonder if this slows down cmp?
   :enabled
   #(if (= "c" (. (get-mode) :mode)) true
        (and (not (in-treesitter-capture? "comment"))
             (not (in-syntax-group? "Comment"))))

   :mapping
   {:<c-space> (m (m.complete) [:i :c])
    :<c-e>     (m {:i (m.abort) :c (m.close)})
    :<c-p>     (m (m.scroll_docs -4) [:i :c])
    :<c-n>     (m (m.scroll_docs 4) [:i :c])
    :<cr>      (m.confirm {:select true})
    :<esc>     (m #(if (visible?) (abort!) ($)) [:i :c])
    :<tab>     (m #(if (expandable-and-not-selected?) (expand!)
                       (visible?) (select-next-item!)
                       (expandable-or-jumpable?) (expand-or-jump!)
                       (has-word-before?) (complete!)
                       ($))
                  [:i :s])
    :<s-tab>   (m #(if (visible?) (select-prev-item!)
                       (backwards-jumpable?) (jump! -1)
                       ($))
                  [:i :s])}})

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

