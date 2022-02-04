; (let [wrap-last-expr
;       (macro wrap-last-expr [last-expr]
;         (if (rawget (. (get-scope) :symmeta) :*module*)
;             `(do ,last-expr ,(sym :*module*))
;             last-expr))
;
;       wrap-module
;       (macro wrap-module [...]
;         (let [body# [...]
;               last-expr# (table.remove body#)]
;           (table.insert body# `(wrap-last-expr ,last-expr#))
;           `(do ,(unpack body#))))]
;
;   (wrap-module (local x 1) (print "test1") {:x 1}))

(local x 1)
{: x :y 2 :z 3}
