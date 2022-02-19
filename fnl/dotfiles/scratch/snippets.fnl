(module dotfiles.scratch.snippets
  {require {a aniseed.core
            ls luasnip}})

; this expands a snippet fine
; should try to implement a cmp source for luasnip
(defn sniptest []
  (ls.snip_expand (a.first ls.snippets.fennel) {}))

