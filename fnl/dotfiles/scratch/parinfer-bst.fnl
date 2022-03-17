(module dotfiles.scratch.parinfer-bst
  {require
   {a aniseed.core
    str dotfiles.util.string}
   require-macros [dotfiles.macros]})


(local (t/ins t/cat) (values table.insert table.concat))

(local buf-set-text vim.api.nvim_buf_set_text)
(local buf-get-lines vim.api.nvim_buf_get_lines)
(local buf-set-lines vim.api.nvim_buf_set_lines)
(local create-buf vim.api.nvim_create_buf)

; (local scratch (or (?. _G :parinfer-scratch)
;                    (let [b (create-buf true true)]
;                      (tset _G :parinfer-scratch b) b)))


(fn diff [strA strB opts]
  (vim.diff strA strB (a.merge {:result_type "indices"} opts)))

(fn set-line-text [buf line cs ce replacement]
  (buf-set-text buf line cs line ce [replacement]))

(fn set-line-text-atomic [buf line cs ce replacement]
  [:nvim_buf_set_text [buf line cs line ce [replacement]]])

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
(defn buf-apply-diff [buf prev prevLines text textLines]
  (ieach-> [[hl hn hle hne] (diff prev text)
            l (hunk2lines hl hn)
            [cs ce replacement] (dl2bst-multi (. prevLines l) (. textLines l))]
    ; (pr (set-line-text-atomic buf (- l 1) cs ce replacement))
    (set-line-text buf (- l 1) cs ce replacement)))

; ; turns out vim.api.nvim_call_atomic doesn't exist so this doesn't work
; ; i don't even know if these loops could possibly take long enough to
; ; necessitate collecting all of them & then batch-executing them, but
; ; it could possibly be implemented but just inserting #(call x y z)
; ; into a table, then using `vim.schedule_wrap` to iterate and call all
; ; of the hashfns at once
; (fn get-bst-calls [buf prev prevLines text textLines]
;   (local calls [])
;   (ieach-> [hunk (diff prev text)
;             l (hunk2lines (. hunk 1) (. hunk 2))
;             [cs ce replacement] (dl2bst-multi (. prevLines l) (. textLines l))]
;     (t/ins calls (set-line-text-atomic buf (- l 1) cs ce replacement)))
;   calls)

; (fn test [linesA linesB]
;   (let [strA (t/cat linesA "\n")
;         strB (t/cat linesB "\n")
;         buftext (t/cat (buf-get-lines scratch 0 -1 false) "\n")]
;     (if (= buftext strA)
;         (do (buf-apply-diff scratch strA linesA strB linesB)
;             "applied diff")
;         (do (buf-set-lines scratch 0 -1 false linesA)
;             (get-bst-calls scratch strA linesA strB linesB)))))


; (test ["" "fn get-cursor-tabs []" ""]
;       ["" "  fn get-cursor-tabs ()" ""])

; (test ["" "fn get-cursor-tabs []"
;        "do-thing" ""]
;       ["" "  fn get-cursor-tabs ()"
;        "do-other-thing" ""])

; (test ["" "fn get-cursor-tabs []"
;        "this line is unchanged"
;        "do-thing" ""]
;       ["" "  fn get-cursor-tabs ()"
;        "this line is unchanged"
;        "do-other-thing" ""])

