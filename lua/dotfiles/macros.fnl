{
 :dbg!          (fn [...]
                  `(let [a# (require "aniseed.core")
                         s# (require "aniseed.string")
                         v# (require "aniseed.nvim")]
                     (if (= (.. (a#.last (s#.split *module-name* "%.")) ".fnl")
                            (a#.last (s#.split (v#.buf_get_name 0) "/")))
                         (values ,...))))
 :nnoremap-old      (fn [lhs rhs ...]
                      (let [a# [lhs rhs] o# [...]]
                        (while (< 0 (length o#))
                          (tset a# (table.remove o# 1) (table.remove o#)))
                       `(vim.keymap.nnoremap ,a#)))
 :viml->fn      (fn [name] `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()"))
 :rand          (fn [...] `(a.rand ,...))
 :string?       (fn [...] `(a.string? ,...))
 :nil?          (fn [...] `(a.nil? ,...))
 :table?        (fn [...] `(a.table? ,...))
 :count         (fn [...] `(a.count ,...))
 :empty?        (fn [...] `(a.empty? ,...))
 :first         (fn [...] `(a.first ,...))
 :second        (fn [...] `(a.second ,...))
 :last          (fn [...] `(a.last ,...))
 :inc           (fn [...] `(a.inc ,...))
 :dec           (fn [...] `(a.dec ,...))
 :even?         (fn [...] `(a.even? ,...))
 :odd?          (fn [...] `(a.odd? ,...))
 :keys          (fn [...] `(a.keys ,...))
 :vals          (fn [...] `(a.vals ,...))
 :kv-pairs      (fn [...] `(a.kv-pairs ,...))
 :run!          (fn [...] `(a.run! ,...))
 :filter        (fn [...] `(a.filter ,...))
 :map           (fn [...] `(a.map ,...))
 :map-indexed   (fn [...] `(a.map-indexed ,...))
 :identity      (fn [...] `(a.identity ,...))
 :reduce        (fn [...] `(a.reduce ,...))
 :some          (fn [...] `(a.some ,...))
 :butlast       (fn [...] `(a.butlast ,...))
 :rest          (fn [...] `(a.rest ,...))
 :concat        (fn [...] `(a.concat ,...))
 :mapcat        (fn [...] `(a.mapcat ,...))
 :pr-str        (fn [...] `(a.pr-str ,...))
 :println       (fn [...] `(a.println ,...))
 :pr            (fn [...] `(a.pr ,...))
 :slurp         (fn [...] `(a.slurp ,...))
 :spit          (fn [...] `(a.spit ,...))
 :merge         (fn [...] `(a.merge ,...))
 :merge!        (fn [...] `(a.merge! ,...))
 :select-keys   (fn [...] `(a.select-keys ,...))
 :get           (fn [...] `(a.get ,...))
 :get-in        (fn [...] `(a.get-in ,...))
 :assoc         (fn [...] `(a.assoc ,...))
 :assoc!        (fn [...] `(a.assoc ,...))
 :assoc-in      (fn [...] `(a.assoc-in ,...))
 :assoc-in!     (fn [...] `(a.assoc-in ,...))
 :update        (fn [...] `(a.update ,...))
 :update!       (fn [...] `(a.update ,...))
 :update-in     (fn [...] `(a.update-in ,...))
 :update-in!    (fn [...] `(a.update-in ,...))
 :constantly    (fn [...] `(a.constantly ,...))}

