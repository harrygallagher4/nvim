(module dotfiles.scratch.parinfer-bst
  {require {a aniseed.core}})


(fn single-line-diff [a b]
  (let [inputA (table.concat (vim.split a "") "\n")
        inputB (table.concat (vim.split b "") "\n")]
    (vim.diff inputA inputB {:result_type "indices" :ignore_cr_at_eol true})))

(fn tbl-reverse [t]
  (local r [])
  (for [i (length t) 1 -1]
    (table.insert r (. t i))) r)

(fn transform-range [i j]
  (if (= j 0) (values i i)
      (values (- i 1) (+ i j -1))))

(fn sld2bst-multi [strA strB]
  (let [diffs (tbl-reverse (single-line-diff strA strB))]
    (icollect [_ [i j u v] (ipairs diffs)]
      (let [(cs ce) (transform-range i j)
            replacement (strB:sub u (math.max (+ u v -1) 0))]
        [cs ce replacement]))))

