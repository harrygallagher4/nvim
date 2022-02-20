
(fn dbg! [...]
  `(let [a# (require "aniseed.core")
         s# (require "aniseed.string")
         v# (require "aniseed.nvim")]
     (if (= (-> *module-name* (s#.split "%.") (a#.last) (.. ".fnl"))
            (-> 0 (v#.buf_get_name) (s#.split "/") (a#.last)))
       (values ,...))))

;; all of the stuff below here is from @gpanders/dotfiles
;; https://raw.githubusercontent.com/gpanders/dotfiles/2dfbd5c1b56b1607149f48ce9d0dd7a910735637/.config/nvim/fnl/macros.fnl

(fn make-ident [key ...]
  "Create a unique identifier for a global function"
  (-> (icollect [_ v (pairs [...])]
        (when (= (type v) :string) (v:lower)))
      (table.concat "_")
      (string.gsub "-" "_")
      (string.gsub "[^%w_]+" "")
      (->> (.. (tostring (gensym key))))))

(fn autocmd* [bang ...]
  (let [args [...]
        group (if (sym? (. args 1)) (tostring (table.remove args 1)))
        [events pat & args] args
        events (if (sequence? events) (table.concat events ",") events)
        flags (icollect [_ v (ipairs args) :until (not= (type v) :string)]
                (do (table.remove args 1)
                    (string.format "++%s" v)))
        ns (make-ident :au (or group :default) (events:gsub "," "_"))
        form `(do (global ,(sym ns) (fn [] ,(unpack args))))]
    (when group
      (table.insert form `(vim.cmd ,(.. "augroup " group))))
    (let [cmd
          (string.format
            "autocmd%s %s %%s %s call v:lua.%s()"
            (if bang :! "") events (table.concat flags " ") ns)]
      (table.insert form `(vim.cmd ,(if (list? pat)
                                        `(: ,cmd :format ,pat)
                                        (cmd:format pat)))))
    (when group
      (table.insert form `(vim.cmd "augroup END")))
    form))

(fn autocmd [...]
  (autocmd* false ...))

(fn autocmd! [...]
  (autocmd* true ...))

(fn augroup [group ...]
  (let [form `(do)]
    (each [_ au (pairs [...])]
      (when (= :autocmd (string.sub (tostring (. au 1)) 1 7))
        (table.insert au 2 group))
      (table.insert form au))
    form))

{: dbg!
 : autocmd
 : autocmd!
 : augroup}

