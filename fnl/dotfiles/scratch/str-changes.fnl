
; {{{ string diff stuff below this point
;


; (fn char-indices [s]
;   (var [r i] [[] 0])
;   (each [c (string.gmatch s ".")]
;     (set i (+ 1 i))
;     (table.insert r [i c])) r)
; (fn tbl-reverse [t]
;   (local r [])
;   (for [i (length t) 1 -1]
;     (table.insert r (. t i))) r)

; ; compute_text_changes *directly* copied from parinfer
; ; *directly* except for computing idx ahead of time
; (fn compute-text-changes [prev-text text]
;   (var [x line-no start-text start-prev different] [1 1 1 1 false])
;   (var end-text (string.len text))
;   (var end-prev (string.len prev-text))
;   (local prev-idx (char-indices prev-text))
;   (local text-idx (char-indices text))

;   (each [_ [i pc] [j c] (f.zip prev-idx text-idx)]
;     (when (~= pc c)
;       (set start-prev i)
;       (set start-text j)
;       (set different true)
;       (lua "break"))
;     (if (= pc "\n")
;         (do (set x 1)
;             (set line-no (+ 1 line-no)))
;         (set x (+ 1 x))))

;   (each [_ [i pc] [j c] (f.zip (tbl-reverse prev-idx) (tbl-reverse text-idx))]
;     (when (or (~= pc c) (< i start-prev) (< j start-text))
;       (set end-prev (+ i 0))
;       (set end-text (+ j 0))
;       (lua "break")))

;   (if different
;     [x line-no
;      (string.sub prev-text start-prev end-prev)
;      (string.sub text start-text end-text)]
;     []))

; (local cs
;   (collect [k v (pairs {:lparen 40 :rparen 41 :lbrak 91 :rbrak 93 :lcurl 123 :rcurl 125})]
;     k (string.char v)))

; (compute-text-changes (.. "abcd" cs.rparen) "abcdef")
; (compute-text-changes "hello" "hexlo") ; -> [3 1 "l" "x"] change 1:3 from l to x
; (compute-text-changes "he\nllo" "he\nxlo") ; -> [1 2 "l" "x"] change 2:1 from l to x
; (compute-text-changes "hello" "helllo") ; -> [5 1 "" "l"] insert l at index 5
; (compute-text-changes "helllo" "hello") ; -> [5 1 "l" ""] delete l at index 5
; (compute-text-changes "<abcd>f" "<abcdf")


; (fn simple-change? [s1 s2]
;   "test if either string is contained in the other"
;   (let [(i j) (string.find s1 s2)]
;     (if (or i j) [1 s1 [i j]]
;       (let [(v u) (string.find s2 s1)]
;         (when (or v u) [2 s2 [v u]])))))
; }}}
