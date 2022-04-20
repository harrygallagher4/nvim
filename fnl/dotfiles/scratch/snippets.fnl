(local a (require :aniseed.core))
(local luasnip (require :luasnip))

(local
  {: snippet               ; s
   : text_node             ; t
   : insert_node           ; i
   : function_node         ; f
   : choice_node           ; c
   : dynamic_node          ; d
   : snippet_node          ; sn
   : restore_node          ; r
   : indent_snippet_node   ; isn
   : absolute_indexer}     ; ai
  luasnip)

(macros
  {:s
   (fn [...] `(,...))})

(macrodebug (s [:opts] (print 1) (print 2) {:opts true}))

(comment
  (s {:trig "fn"}
     "(fn " (1) " "
     "[" (2) "]"
     (t "" " (")
     (0) "))"))

(comment
  (s {:trig "fn"}
     "(fn " 1 " "
     "[" 2 "]"
     ("" " (")
     0 "))"))

{}

;; ((fn [...] (select "#" ...)) :a :b :c :d)


;; (snippet       {:kv-table} (node...) {:kv-table})
;; (text          "string" "string?")
;; (insert        number "string?")
;; (func          [args snip] [node args] {kv-table :user-args})
;; (choice        number (node...) {kv-table})
;; (snippet-node  number (node...))
;; (isn           number (node...) "string")
;; (dynamic       [args parent old-state user...] [node args] {kv-table :user-args})
;; (restore       number "string" (node...))

;; (fn snippet              [ {opts} [nodes] ?{cond}   ])
;; (fn text_node            [ text ] || [ [ lines ] ]   )
;; (fn insert_node          [ index ?text              ])
;; (fn function_node        [ fn [?deps]               ])
;; (fn choice_node          [ pos [nodes] ?{opts}      ])
;; (fn snippet_node         [ pos [nodes]              ])
;; (fn indent_snippet_node  [ pos [nodes] indent       ])
;; (fn dynamic_node         [ pos fn [?deps] ... ?args ])
;; (fn restore_node         [ pos key ?[nodes]         ])
;; (fn absolute_indexer     [ idx ... ?sub             ])

;;
;; local s     = "luasnip".            snippet
;; local sn    = "luasnip".            snippet_node
;; local t     = "luasnip".            text_node
;; local i     = "luasnip".            insert_node
;; local f     = "luasnip".            function_node
;; local c     = "luasnip".            choice_node
;; local d     = "luasnip".            dynamic_node
;; local r     = "luasnip".            restore_node
;; local l     = "luasnip.extras".     lambda
;; local rep   = "luasnip.extras".     rep
;; local p     = "luasnip.extras".     partial
;; local m     = "luasnip.extras".     match
;; local n     = "luasnip.extras".     nonempty
;; local dl    = "luasnip.extras".     dynamic_lambda
;; local fmt   = "luasnip.extras.fmt". fmt
;; local fmta  = "luasnip.extras.fmt". fmta
;; local types = "luasnip.util.types"
;; local conds = "luasnip.extras.expand_conditions"
;;
