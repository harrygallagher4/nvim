(local a (require :aniseed.core))

(let
  [if?

   (macro if? [expr ...]
     (if (list? expr)
       `(if ,expr ,...)
       (let [[bind cond] expr]
         `(let [,bind ,cond]
            (if ,bind ,...)))))]

  (macrodebug
    (if? [x (math.max 420 69)]
      (* x 2) x))
  (macrodebug
    (if? (math.max 420 69)
      (print "test"))))

{:x "this is returned from a non-aniseed file"
 :aniseed a}

