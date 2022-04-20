
(do
  (each [scope (iter-scope-tree node bufnr)]
    (let [entry (. defs (get-definition-id scope text))]
      (if (not= nil entry)
          (lua "return entry.node, scope, entry.kind")
          (>= thing entry)
          (lua "return thing.node, scope, thing.kind"))))
  (values node (get-root node) nil))

