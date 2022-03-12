
(fn sym2api [s]
  (->> (-> s
           (tostring)
           (string.gsub "-" "_"))
       (.. "vim.api.nvim_")
       (sym)))

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


{: dbg! : use-api}

