((list .
   (symbol) @_defn .
   (symbol) @definition.function .
   (sequential_table))
 (#match? @_defn "^defn\-?$"))

((list .
   (symbol) @_def .
   (symbol) @definition.var)
 (#match? @_def "^def\-?$"))

((list .
   (symbol) @_mod .
   [(symbol) (multi_symbol)] .
   (table
     (symbol) @_modfunc .
     [(sequential_table)
      (table .
        ((symbol) @definition.var . (_) @from))]
     (#any-of? @_modfunc "require" "import" "require-macros" "import-macros" "autoload")))
 (#eq? @_mod "module"))

