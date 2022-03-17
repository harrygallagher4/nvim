
((list
   (multi_symbol
     (symbol) @_vim
     (symbol) @_cmd)
   (string) @vim)
  (#eq? @_vim "vim")
  (#eq? @_cmd "cmd")
  (#offset! @vim 0 1 0 -1))

((list
   (multi_symbol
     (symbol) @_ffi
     (symbol) @_cdef)
   (string) @c)
  (#eq? @_ffi "ffi")
  (#eq? @_cdef "cdef")
  (#offset! @c 0 1 0 -1))
