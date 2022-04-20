
(local luasnip* (gensym :luasnip))
(local snippet* (gensym :snippet))
(local text-node* (gensym :text-node))
(local insert-node* (gensym :insert-node))
(local function-node* (gensym :function-node))
(local choice-node* (gensym :choice-node))
(local snippet-node* (gensym :snippet-node))
(local indent-snippet-node* (gensym :indent-snippet-node))
(local dynamic-node* (gensym :dynamic-node))
(local restore-node* (gensym :restore-node))

(fn msym [base key]
  (sym (.. (tostring base) "." key)))

(fn use-luasnip-macros [ls]
  `(local (,luasnip*
           ,snippet*
           ,text-node*
           ,insert-node*
           ,function-node*
           ,choice-node*
           ,snippet-node*
           ,indent-snippet-node*
           ,dynamic-node*
           ,restore-node*)
     (values ,ls
             ,(msym ls "snippet")
             ,(msym ls "text_node")
             ,(msym ls "insert_node")
             ,(msym ls "function_node")
             ,(msym ls "choice_node")
             ,(msym ls "snippet_node")
             ,(msym ls "indent_snippet_node")
             ,(msym ls "dynamic_node")
             ,(msym ls "restore_node"))))

;; list?
;; sym?
;; table?
;; sequence?

(fn kv-tbl? [arg]
  (and (not (sequence? arg)) (table? arg)))

(fn first [tbl]
  (. tbl 1))

(fn last [tbl]
  (. tbl (length tbl)))

(fn first-is? [tbl pred]
  (pred (first tbl)))

(fn last-is? [tbl pred]
  (pred (last tbl)))

(fn snippet-args [...]
  (var ?cond nil)
  (let [nodes [...]]
    (when (last-is? nodes kv-tbl?)
      (set ?cond (table.remove nodes)))
    [nodes ?cond]))

(fn snippet [opts ...]
  (let [[nodes cond] (snippet-args ...)]
    `(,snippet* ,nodes ,cond)))

(fn text-node [...]
  (if (= 1 (select "#" ...))
      `(,text-node* [,...])
      `(,text-node* [[,...]])))

;; don't really need a macro for this
(fn insert-node [idx text]
  `(insert-node* idx text))

(fn function-node [args inputs ...]
  `(function-node* (fn ,args ,...) ,inputs))

(fn choice-node-args [...]
  (var ?opts nil)
  (let [nodes [...]]
    (when (last-is? nodes kv-tbl?)
      (set ?opts (table.remove nodes)))
    [nodes ?opts]))

(fn choice-node [idx ...]
  (let [[nodes opts] (choice-node-args ...)]
    `(choice-node* ,idx ,nodes ,opts)))

(fn snippet-node [idx nodes]
  `(snippet-node* ,idx [,nodes]))

(fn indent-snippet-node-args [...]
  (let [nodes [...]
        indent (table.remove nodes)]
    [nodes indent]))

(fn indent-snippet-node [idx ...]
  (let [[nodes indent] (indent-snippet-node-args ...)]
    `(indent-snippet-node* ,idx ,nodes ,indent)))

(fn dynamic-node-args [...]
  (var ?node-args nil)
  (var ?user-args nil)
  (var ?opts nil)
  (let [nodes [...]]
    (when (last-is? nodes kv-tbl?)
      (set ?opts (table.remove nodes)))
    (when (first-is? nodes sequence?)
      (set ?node-args (table.remove nodes 1)))
    (when (first-is? nodes sequence?)
      (set ?user-args (table.remove nodes 1)))
    (when ?user-args
      (if ?opts
          (tset ?opts :user_args ?user-args)
          (set ?opts {:user_args ?user-args})))
    {:body (first nodes) : ?node-args : ?opts}))

;; TODO support both if possible
;; 1.  (d [fn-args] [nodes] [user] (body...) {opts})
;; 2.  (d [fn-args] [nodes] (body...) {opts})
;; 3.  (d fn-symbol [nodes] [user] {opts})
;; - user-args in signature #1 is probably never useful,
;;   decide between #1 and #2
;; - since the arguments passed to the anonymous function in #1/#2 are
;;   always the same, maybe just bind those symbols in the body and
;;   drop [fn-args] entirely?
;; - instead of using a seq for user-args it might make more sense
;;   to use a list, that would make it more like a function call
;; - honestly user-args is probably never useful at all, i think it
;;   can always be replaced by a higher-order function
;; most of these notes will also apply to function-node
(fn dynamic-node [idx fn-args ...]
  (let [{: ?node-args
         : body
         : ?opts} (dynamic-node-args ...)
        node-args (if ?node-args ?node-args [])
        opts (if ?opts ?opts {})]
    `(dynamic-node* idx
                    (fn ,fn-args ,body)
                    ,node-args
                    ,opts)))


;; just seeing how different shorthands look, snippet is from examples.
;; no special character looks fine, but the function names sort
;; of blend in with the actual text, ^ is a nice way to indicate
;; a node. although each function call is a node obviously
;
; (S (c 1
;       (t "public ")
;       (t "private "))
;    (t "class ")
;    (i 2)
;    (t " ")
;    (c 3
;       (t "<")
;       (s nil
;          (t "extends ")
;          (r :other_class
;             (i 1))
;          (t " <"))
;       (s nil
;          (t "implements ")
;          (r :other_class)
;          (t " <")))
;    (t ""
;       "\t")
;    (i 0)
;    (t ""
;       ">"))
;
; (snippet (choi 1
;                (text "public ")
;                (text "private "))
;          (text "class ")
;          (insn 2)
;          (text " ")
;          (choi 3
;                (text "<")
;                (snip nil
;                      (text "extends ")
;                      (rest :other_class
;                            (insn 1))
;                      (text " <"))
;                (snip nil
;                      (text "implements ")
;                      (rest :other_class)
;                      (text " <")))
;          (text ""
;                "\t")
;          (insn 0)
;          (text ""
;                ">"))
;
; (S^ (c^ 1
;         (t^ "public ")
;         (t^ "private "))
;     (t^ "class ")
;     (i^ 2)
;     (t^ " ")
;     (c^ 3
;         (t^ "<")
;         (s^ nil
;             (t^ "extends ")
;             (r^ :other_class
;                 (i^ 1))
;             (t^ " <"))
;         (s^ nil
;             (t^ "implements ")
;             (r^ :other_class)
;             (t^ " <")))
;     (t^ ""
;         "\t")
;     (i^ 0)
;     (t^ ""
;         ">"))
;

{: dynamic-node-args : dynamic-node : use-luasnip-macros}

