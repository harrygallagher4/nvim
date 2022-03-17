

; (local scratch (or (?. _G :parinfer-scratch)
;                    (let [b (create-buf true true)]
;                      (tset _G :parinfer-scratch b) b)))

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

