
(macro return-if [cond value]
  (if (= nil value)
      `(if ,cond (lua "return "))
      (let [rsym (gensym)]
        `(if ,cond
             (let [,rsym ,value]
               (lua ,(.. "return "
                         (tostring rsym))))))))

(local x {:test false})
(local ret "returned string")

(fn test []
  (local ret-value 420)
  (return-if (= :table (type x)) 420)
  "other value")

