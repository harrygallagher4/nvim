(module dotfiles.scratch.iterators
  {require {a aniseed.core fun fun}})

(local {: reverse : gmatch : len} string)
(local {: iter : map : zip : foreach} fun)

; from http://lua-users.org/wiki/IteratorsTutorial
; an iteratee(?) that returns ((n+1) (n+1)^2) up to `state`
(fn square [state n]
  (when (< n state)
    (let [nn (+ 1 n)]
      (values nn (* nn nn)))))

; another from lua-users wiki
; $  (each [i j (squares 5)] [i j])
; $  -> [1 1] [2 4] [3 9] [4 16] [5 25]
(fn squares [up-to]
  (values square  up-to   0))
;         ^it     ^state  ^initial value
; - `state` is always passed as the first argument to `it`
; - `initial` is never propogated to iteration but is passed to `it`
; the first values bound by iteration come from the first call to
; $  (it state initial)
; $  -> x y z...
; the second call to `it` is
; $  (it state x)
; with `state` in tact.
; `state` does not depend on return value of `it` but can be "mutated"
; if it is a table


; plain lua iterator
; $  (each [c i (it-rev-str "abcdef")] [c i])
; $  -> (f 6) (e 5) (d 4) (c 3) (b 2) (a 1)
; since the iterator's state is enclosed (i & it) we can just return an
; anonymous function that takes no arguments without needing to give it
; a `state` value or initial value
(fn it-rev-str [s]
  (var i (+ 1 (len s)))
  (local it (-> s (reverse) (gmatch ".")))
  #(when (> i 1)
     (set i (- i 1))
     (values (it) i)))

; reverse-char-indices: (+ (string.len s) -i 1)
; ^ string.len is the index of the last char
(fn reverse-char-indices [s]
  (var [len r] [(string.len s) []])
  (each [c x (string.gmatch (s:reverse) ".")]
    (table.insert r [len c])
    (set len (- len 1))) r)


;; luafun stuff below here
;; -----------------------
;
; this is messy looking but `match` makes testing all of the conditions
; at once really clean
; [(>= nargs 3) (. args (- nargs 2)) (. args (- nargs 1)) (. args nargs)]
(fn fun-clean-vararg [...]
  (let [args [...] nargs (select :# ...)]
    (match
      (#[(>= $ 3) (. $2 (- $ 2)) (. $2 (- $ 1)) (. $2 $)] nargs args)
      [true {: param : state} param state]
      (do (table.remove args nargs)
          (table.remove args (- nargs 1))
          (values (- nargs 2) args))
      _ (values nargs args))))

(fn fun-rev-str-gen [s-iter c]
  (when (> c 0)
    (values (- c 1) (s-iter) c)))

(fn fun-rev-str [s]
  (iter
    fun-rev-str-gen
    (-> s (reverse) (gmatch "."))
    (len s)))


; wraps an iterator's return values in a tablle
(fn fun-multi-wrapper [...] [...])
(fn fun-wrap-multi [it] (map fun-multi-wrapper it))
; like fun.zip but works with multi-return iterators by enclosing their
; values in a table
(fn fun-zip-multi [...]
  (let [(n args) (fun-clean-vararg ...)]
    (->> args
         (a.map fun-wrap-multi)
         (unpack)
         (zip))))

; (comment
;   (foreach
;     a.pr
;     (fun-wrap-multi
;       (fun-zip-multi
;         (fun-rev-str "abcdef")
;         (fun-rev-str "abcdef")
;         (fun-rev-str "uvwxyz")))))

