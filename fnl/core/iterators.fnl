
(fn sriapi-it* [t i]
  (set-forcibly! i (- i 1))
  (when (not= 0 i)
    (values i (. t i))))

(fn sriapi [list-like]
  (values sriapi-it*
          list-like
          (+ 1 (length list-like))))

{: sriapi
 :reverse-ipairs sriapi}

