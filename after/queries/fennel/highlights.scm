
(fn docstring: (string) @comment
  (#set! @comment "priority" 201))

((list .
  (symbol) @_defn .
  [(symbol) (multi_symbol)] .
  (sequential_table) .
  (string) @comment .
  (_)+)
 (#any-of? @_defn "defn" "defn-"))

