(module dummy)


;
; most treesitter nodes should be below
; -------------------------------------

; (local [x y] (do-thing))
; (local {x y} (do-thing))

; (collect [a b (test)])
; (icollect [])
; (each [])
; (for [i 1 2])
; (global x 1)
; (lambda [x y z] (print x y z))
; (let [x 1] (print x))
; (match [1 2 3]
;   [a b 2] true
;   (where [a b 3] (< a 2)) true)
; (set x 1)
; (var x 1)

