(require-macros :parinfer.macros)
(local {: merge} (require :parinfer.util))

(local (t/ins t/cat) (values table.insert table.concat))

(local buf-set-text vim.api.nvim_buf_set_text)
(local buf-get-lines vim.api.nvim_buf_get_lines)
(local buf-set-lines vim.api.nvim_buf_set_lines)
(local create-buf vim.api.nvim_create_buf)


(fn diff [strA strB opts]
  (vim.diff strA strB (merge {:result_type "indices"} opts)))

(fn set-line-text [buf line cs ce replacement]
  (buf-set-text buf line cs line ce [replacement]))

; @params (A B) strings to compare. Must not be multi-line strings (no '\n')
; @returns [[i j u v]] where (i j) and (u v) are (start, count) ranges
;        corresponding to strings A and B, respectively
(fn diff-line [a b]
  (let [inputA (t/cat (vim.split a "") "\n")
        inputB (t/cat (vim.split b "") "\n")]
    (diff inputA inputB {:ignore_cr_at_eol true})))

(fn t/rev [t]
  (local r [])
  (for [i (length t) 1 -1]
    (t/ins r (. t i))) r)

; @params (i j) single-line-diff style range
; @returns (start_col end_col)
(fn transform-range [i j]
  (if (= 0 j) (values i i)
      (values (- i 1) (+ i j -1))))

(fn hunk2lines [i j]
  (if (= 0 j) [-1]
      (let [range []]
        (for [x i (+ i j -1)]
          (t/ins range x)) range)))

(fn dl2bst-multi [strA strB]
  (icollect [_ [i j u v] (ipairs (t/rev (diff-line strA strB)))]
    (let [(cs ce) (transform-range i j)]
      [cs ce (strB:sub u (math.max (+ u v -1) 0))])))

; needs to be able to handle cases where one line is replaced with two
; or two lines replaced with one, etc. (actually maybe it doesn't need
; to be able to handle that)
; TODO: investigate whether parinfer will ever entirely delete a line
(fn buf-apply-diff [buf prev prevLines text textLines]
  (ieach-> [[hl hn hle hne] (diff prev text)
            l (hunk2lines hl hn)
            [cs ce replacement] (dl2bst-multi (. prevLines l) (. textLines l))]
    (set-line-text buf (- l 1) cs ce replacement)))


{: buf-apply-diff}

