
(fn function-node [args inputs ...]
  `((. (require "luasnip") :f) (fn ,args ,...) ,inputs))

{:f function-node}

