
(fn ieach-rec [i levels body]
  (if (> i (length levels)) body
      `(each [,(gensym) ,(. levels i 1) (ipairs ,(. levels i 2))]
         ,(ieach-rec (+ 1 i) levels body))))
(fn ieach [bindings body]
  (local levels [])
  (each [i form (ipairs bindings)]
    (if (= 1 (% i 2))
        (table.insert levels [form])
        (table.insert (. levels (/ i 2)) form)))
  (ieach-rec 1 levels body))


(fn sym2api [s]
  (->> (-> s (tostring) (string.gsub "-" "_"))
       (.. "vim.api.nvim_") (sym)))
(fn use-api [...]
  `(local (,(unpack [...]))
     (values ,(unpack (icollect [_ v (ipairs [...])]
                        (sym2api v))))))


(fn dbg! [...]
  `(let [a# (require "aniseed.core")
         s# (require "aniseed.string")
         v# (require "aniseed.nvim")]
     (if (= (-> *module-name* (s#.split "%.") (a#.last) (.. ".fnl"))
            (-> 0 (v#.buf_get_name) (s#.split "/") (a#.last)))
       (values ,...))))


(fn apply-> [initial ...]
  (let [(func args) (if (sym? initial) initial
                        (values (table.remove initial 1) [(unpack initial)]))
        forms [...]]
    (each [i f (ipairs forms)]
      (table.insert (. forms i) 1 func)
      (when args
        (each [j arg (ipairs args)]
          (table.insert (. forms i) (+ 1 j) arg))))
    `(do
       ,(unpack forms))))


{: dbg! : use-api :ieach-> ieach : apply->}

