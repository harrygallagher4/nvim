
(fn dbg! [...]
  `(let [a# (require "aniseed.core")
         s# (require "aniseed.string")
         v# (require "aniseed.nvim")]
     (if (= (-> *module-name* (s#.split "%.") (a#.last) (.. ".fnl"))
            (-> 0 (v#.buf_get_name) (s#.split "/") (a#.last)))
       (values ,...))))

{: dbg!}

