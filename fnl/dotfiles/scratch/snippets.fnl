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

; ((fn [...] (select "#" ...)) :a :b :c :d)


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

