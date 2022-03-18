
(fn merge-arg [...]
  (local tbl [])
  (for [i 1 (select "#" ...)]
    (let [v (select i ...)]
      (when (not= nil v) (table.insert tbl v))))
  tbl)

(fn merge-left [...]
  (let [args (merge-arg ...)]
    (if (= 1 (length args))
      (. args 1)
      (vim.tbl_extend "keep" (unpack args)))))

(fn merge-right [...]
  (let [args (merge-arg ...)]
    (if (= 1 (length args))
      (. args 1)
      (vim.tbl_extend "force" (unpack args)))))


{: merge-left : merge-right
 :merge merge-right
 :lmerge merge-left
 :rmerge merge-right}

