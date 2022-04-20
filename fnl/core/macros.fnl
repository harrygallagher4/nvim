
(fn copy [t]
  (let [out []]
    (each [_ v (ipairs t)] (table.insert out v))
    (setmetatable out (getmetatable t))))

;; this is taken from fennel's macros, used to seperate iterator
;; arguments from the :into clause in each, collect, etc.
;;
;; > (let [(into iter) (extract-into iter-args)]
;; >   `(each ,iter ...))
(fn extract-where [iter-tbl]
  (var (where iter-out found?) (values [] (copy iter-tbl)))
  (for [i (length iter-tbl) 2 -1]
    (if (= :where (. iter-tbl i))
        (do (assert (not found?) "expected only one :where clause")
            (set found? true)
            (set where (. iter-tbl (+ i 1)))
            (table.remove iter-out i)
            (table.remove iter-out i))))
  (assert (or (not found?) (sym? where) (table? where) (list? where))
          "expected table, function call, or symbol in :where clause")
  (values where iter-out))

(fn iter-binding [iter-tbl]
  (icollect [_ bind (ipairs iter-tbl)
             :until (list? bind)]
    (when (and (sym? bind)
               (not= "_" (tostring bind)))
      bind)))

(fn ident? [value]
  `(if ,value ,value))

(fn nor [...]
  `(not (and ,...)))

(fn dotfirst [value]
  `(. ,value 1))

(fn dotlast [value]
  `(. ,value (length ,value)))

;; the automatic capturing of `val` is very naive and could possiby
;; break things in some cases
(fn seek [iter where value-expr ...]
  (let [done? (gensym "done?")
        val (or value-expr
                (let [bindings (iter-binding iter)]
                  (if (= 1 (length bindings))
                      (. bindings 1)
                      `(values ,(unpack bindings)))))]
    ; (table.insert iter :until)
    ; (table.insert iter done?)
    `(do
       (var ret# nil)
       ; (var ,done? false)
       (each ,iter
         (when ,where
           (set ret# ,val)
           (lua :break)))
           ; (set ,done? true)))
       ret#)))

;; the dance this function does with gensym is in order to get the
;; post-mangling name, there's no official way to do that in a macro
;; although it would probably be possible with
;; (. (get-scope) :manglings)
(fn return-if! [cond value]
  (if (= nil value)
      `(if ,cond (lua "return "))
      (let [rsym (gensym)]
        `(if ,cond
             (let [,rsym ,value]
               (lua ,(.. "return " (tostring rsym))))))))

(fn ieach-rec [i levels body]
  (if (> i (length levels)) body
      `(each [,(gensym) ,(. levels i 1) (ipairs ,(. levels i 2))]
         ,(ieach-rec (+ 1 i) levels body))))

(fn ieach^ [bindings body]
  (local levels [])
  (each [i form (ipairs bindings)]
    (if (= 1 (% i 2))
        (table.insert levels [form])
        (table.insert (. levels (/ i 2)) form)))
  (ieach-rec 1 levels body))

(fn each^ [bindings body j]
  (let [i (if (= nil j) 1 j)]
    (if (> i (length bindings)) body
        `(each ,(. bindings i)
           ,(each^ bindings body (+ 1 i))))))

{: ident?
 : nor
 : dotfirst
 : dotlast
 : return-if!
 : seek
 : ieach^
 : each^}

