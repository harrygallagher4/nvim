((list .
   (symbol) @keyword.function .
   (symbol) @function)
 (#match? @keyword.function "^defn\-?$"))

((list .
   (symbol) @keyword)
 (#match? @keyword "^def\-?$"))

((symbol) @include
 (#eq? @include "autoload"))

