(module dotfiles.scratch.parinfer-misc
  {require {a aniseed.core}})

(local buf 92)
(local _ 2)
(local diffopts {:result_type "indices" :ignore_whitespace false :ignore_whitespace_change false :ignore_whitespace_change_at_eol false :ignore_cr_at_eol true :ignore_blank_lines false})
(local cs
  (collect [k v (pairs {:lp 40 :rp 41 :lb 91 :rb 93 :lc 123 :rc 125})]
    k (string.char v)))

(fn str-insert [self ins idx]
  (.. (self:sub 1 idx) ins (self:sub (+ idx 1))))

(= 7 (string.len "testing"))
(str-insert "testing" "|" 0) ; => "|testing"
(str-insert "testing" "|" 3) ; => "tes|ting"
(str-insert "testing" "|" 7) ; => "testing|"

(local line-change-pre (table.concat (vim.split "(fn get-cursor-tabs [])" "") "\n"))
(local line-change-post (table.concat (vim.split "(fn get-cursor-tabs-post [])" "") "\n"))

(vim.diff line-change-pre line-change-post diffopts)

; (fn single-line-diff [a b]
;   (let [inputA (.. (table.concat (vim.split a "") "\n") "\n")
;         inputB (.. (table.concat (vim.split b "") "\n") "\n")]
;     (vim.diff inputA inputB {:result_type "indices"})))
; (fn sld-unified [a b]
;   (let [inputA (.. (table.concat (vim.split a "") "\n") "\n")
;         inputB (.. (table.concat (vim.split b "") "\n") "\n")]
;     (vim.diff inputA inputB {:result_type "unified"})))
(fn single-line-diff [a b]
  (let [inputA (table.concat (vim.split a "") "\n")
        inputB (table.concat (vim.split b "") "\n")]
    (vim.diff inputA inputB {:result_type "indices" :ignore_cr_at_eol true})))
(fn sld-unified [a b]
  (let [inputA (table.concat (vim.split a "") "\n")
        inputB (table.concat (vim.split b "") "\n")]
    (vim.diff inputA inputB {:result_type "unified" :ignore_cr_at_eol true})))

(fn tbl-reverse [t]
  (local r [])
  (for [i (length t) 1 -1]
    (table.insert r (. t i))) r)

; INSERTION
(do (single-line-diff "(fn get-cursor-tabs [])" "(fn get-cursor-tabs-post [])")
    [[19 0  20 5]])
"-----i--j--u--v-----------------------------------"
(string.sub "(fn get-cursor-tabs [])" 1 19) ; head for insertion
(string.sub "(fn get-cursor-tabs [])" 20) ; tail for insertion
"20-24 because 5 chars *including* char 20. u to u + (v - 1)"
(string.sub "(fn get-cursor-tabs-post [])" 20 24) ; text to be inserted

; DELETION
(do (single-line-diff "(fn get-cursor-tabs-post [])" "(fn get-cursor-tabs [])")
    [[20 5 19 0]])
(string.sub "(fn get-cursor-tabs-post [])" 20 24) ; 2bD: "-post" string to be deleted
(string.sub "(fn get-cursor-tabs-post [])" 1 19) ; everything before 2bD
(string.sub "(fn get-cursor-tabs-post [])" 25) ; everything after 2bD

(string.sub "(fn get-cursor-tabs [])" 19 18)
; ^^ empty string (just testing the case where j or v = 0 so length is negative)

; CHANGE
(do (single-line-diff "(fn get-cursor-tabs [])" "(fn get-xxxxxx-tabs [])")
    [[9 6 9 6]])
; CHANGE with DELETION
(do (single-line-diff "(fn get-cursor-tabs [])" "(fn get-xxxx-tabs [])")
    [[9 6 9 4]])
; INSERTION into empty string
(do (single-line-diff "" "(fn get-cursor-tabs [])")
    [[0 0 1 23]])
; DELETION of entire string
(do (single-line-diff "(fn get-cursor-tabs [])" "")
    [[1 23 0 0]])
; change of indent and change of parenTrail
(do (single-line-diff (.. "close" cs.rp cs.rp) (.. "  close" cs.rp cs.rb cs.rp))
    [[0 0 1 2] [6 0 9 1]])


(fn [a b]
  (let [[[a b c d]] (single-line-diff a b)]
    (match [a b c d]
      [i 0 u v] "insertion: A(1, i) .. B(u, u+(v-1)) .. A(i+1)"
      [i j u 0] "deletion: A(1, (i-1)) .. A(i+j)"
      [i j i j] "change"
      (where [i j i v] (> j v)) "change with deletion"
      (where [i j i v] (> v j)) "change with +/-")))


(single-line-diff "fn get-cursor-tabs []" "n get-cursor-tabs []")
(string.sub "(fn get-cursor-tabs [])xxxxxxx" 24 30)
(string.sub "(fn get-cursor-tabs-post [])" 24 30)
(string.sub "(fn get-cursor-tabs [])" 19 18)

; (vim.api.nvim_buf_set_text buf 1 23 1 23 [""])

; SLD = [23 0 24 7]
; length 0 range: insertion. start: 23 end: 23
; [23 - 23]
; range: 0 sub: 7
; (i, i + j)
; B:sub(24, 24 + 7 - 1) (24, 30)
; B:sub(u,  u  + v - 1) => "xxxxxxx"
; appends to a 23 char line, so zero indexed "22 char line"
; (vim.api.nvim_buf_set_text buf 1 23 1 23 ["xxxxxxx"])

; SLD = [20 5 19 0]
;         ^ ^ range, text is length 0 so empty
; [19 - 24]
; range: 5 sub: 0
; [(i - 1) - ((i - 1) + j)]
; B:sub(19, 19 + 0 - 1) (19, 18)
; B:sub(u,  u  + v - 1) => ""
; delete "-post" from the sample line
; (vim.api.nvim_buf_set_text buf 0 19 0 24 [""])

; SLD = [0 0 1 2]
; range is zero-length so this is an insertion AT index zero.
; [0 - 0]
; range: 0 sub: 2
; B:sub(1, 1 + 2 - 1) (1, 2)
; B:sub(u, u + v - 1) => "  "
; add spaces at start
; (vim.api.nvim_buf_set_text buf 0 0 0 0 ["  "])

;...............................................................................
(fn $ [cs ce t] (vim.api.nvim_buf_set_text 92 2 cs 2 ce [t]))
(local $ #$)

; with SLD
; [i j u v]
; `i` selects a character, including char(0) which is before the string
; `j` is the width of the selection, *including* the selected character
;
; (1, 1) acts ON char(1)
; (0, 0) positions a "cursor" after char(0), which means inserting at the head
; (1, 0) positions a "cursor" *after* char(1)
; I'm pretty sure (0, 1) is impossible, and would represent *replacing* char(0)
; which is the same as inserting after char(0)
;
;                                                                              |
; =SLD=                        =BST=                                           |
; (0, 0)  _||_  _               (0, 0)  _||_  _                                |
;         0  1  2                       %  0  1                                |
; (1, 1)  _ |_| _               (0, 1)  _ |_| _                                |
;         0  1  2                       %  0  1                                |
; (1, 0)  _  _||_               (1, 1)  _  _||_                                |
;         0  1  2                       %  0  1                                |
; (2, 1)  _  _ |_|              (1, 2)  _  _ |_|                               |
;         0  1  2                       %  0  1                                |
; (1, 2)  _ |_  _|              (0, 2)  _ |_  _|                               |
;         0  1  2                       %  0  1                                |
;                                                                              |
;                               0  1  2                                        |
;         0 1 2                 _  _  _                                        |
;         ^$                     ^$                                            |
; j>0       ^                     * ^$                                         |
;                                   ^$                                         |
;                                    * ^$                                      |
;                                 * ^  $                                       |
;                                                                              |
;                                                                              |
; R(i, j) =                                                                    |
; if j > 0 start before char(i)               (0, 0): (0, 0)                   |
;          end after char(i + j - 1)          (1, 1): (0, 1)                   |
; if j = 0 start after char(i)                (1, 0): (1, 1)  yayyyyyyy        |
;          end after char(i + j)              (2, 1): (1, 2)                   |
;                                             (1, 2): (0, 2)                   |
; j > 0:  char(i - 1) - char(i + j - 1)                                        |
; j = 0:  char(i) - (char i + j)                                               |
;                                                                              |

; `start_col` and `end_col` can sort of be viewed as the left and right
; ends of a VISUAL selection, except that it can be zero-width in which
; case text just gets inserted.
; start_col = 0 sets the left end before the *first* char
; start_col = 1 sets the left end before the *second* char (which is the same as *after* the first char)
; end_col = 0 sets the right end before the first char
; end_col = 1 sets the right end to AFTER the *first* char
;
; in a sense
; col(x) = left of char(x + 1)
; col(x) = right of char(x), but there is no char(0)

; fn get                                          |
; _n get                                          |
; replace the first char with a space             |
; range: 1 sub: 1            1 1    2             |
; [1 1 1 1]                  0 1                  |
($ 0 1 " ");                 0      1             |

; fn get                                          |
; f  get                                          |
; replace the *second* char with space            |
; range: 1 sub: 1            2 1    3             |
; [2 1 2 1]                  1 2                  |
($ 1 2 " ");                 1      2             |

; fn get                                          |
; n get                                           |
; delete first char                               |
; range: 1 sub: 0            1 1    2             |
; [1 1 0 0]                  0 1                  |
($ 0 1 "");                  0      1             |

;                                                 |
;                                                 |
;                                                 |
; delete second char         2 1    3             |
; [2 1 1 0]                  1 2                  |
($ 1 2 "");                  1      2             |

; fn get                                          |
;  get                                            |
; delete first two chars                          |
; range: 2 sub: 0            1 2    3             |
; [1 2 0 0]                  0 2                  |
($ 0 2 "");                  0      2             |

; fn get                                          |
; _fn get                                         |
; insert a space at the beginning of the line     |
; range: 0 sub: 1            0 0    0             |
; [0 0 1 1]                  0 0                  |
($ 0 0 " ");               (-1)   (-1)            |

; fn get                                          |
; f_n get                                         |
; insert a space *after* the first char           |
; range: 0 sub: 1            1 0    1             |
; [1 0 2 1]                  1 1                  |
($ 1 1 " ");                 0      0             |

;                                                 |
;                            i j   (i + j)        |
;                            s e                  |
;                           (i - 1)(i + j - 1)    |



(single-line-diff "fn get-cursor-tabs []" "fn get-cursor-tabs []")

(fn transform-range [i j]
  (if (= j 0) [i i]
      [(- i 1) (+ i j -1)]))

(transform-range 1 0) ; => [1 1]
(transform-range 1 1) ; => [0 1]
(transform-range 2 1) ; => [1 2]
(transform-range 1 1) ; => [0 1]
(transform-range 2 1) ; => [1 2]
(transform-range 1 2) ; => [0 2]
(transform-range 0 0) ; => [0 0]
(transform-range 1 0) ; => [1 1]
(transform-range 2 0) ; => [2 2]
; all check out

; this function works as long as there's just a single change
(fn sld2bst [strA strB]
  (let [[[i j u v]] (single-line-diff strA strB)
        replacement (strB:sub u (math.max (+ u v -1) 0))
        [cs ce] (transform-range i j)]
    (values cs ce replacement)))

(fn sld2bst-multi [strA strB]
  (let [diffs (tbl-reverse (single-line-diff strA strB))]
    (icollect [_ [i j u v] (ipairs diffs)]
      (let [[cs ce] (transform-range i j)
            replacement (strB:sub u (math.max (+ u v -1) 0))]
        [cs ce replacement]))))

(sld2bst "fn get-cursor-tabs []" "  n get-cursor-tabs []")
(sld-unified "abcdefg" "  abcde")

(sld2bst-multi "abcdefg" "  abcde")

;;
;; plain vim.diff notes
; result is [[11 1 11 1] [16 8 15 0]]
;
; [11 1 11 1] => one line changed
; 1 line, starting at 11 (so just line 11) was removed, and 1 line,
; starting at 11 was inserted. "removed" as in removed from `pre` and
; "inserted" as in inserted into `post`
;
; [16 8 15 0] => eight lines deleted
; 8 lines, starting at 16 were removed, and ZERO lines, starting at 15,
; were inserted. since no lines were inserted the change is a deletion
;
; swapping pre & post yields
; [[11 1 11 1] [15 0 16 8]]
;



(fn get-cursor-tabs []
  "gets cursor position, (0, 0) indexed. takes tab width into account"
  (let [cursor (vim.api.nvim_win_get_cursor 0)]
    [(+ (. cursor 1) -1)
     (+ -1 (vim.fn.virtcol "."))]))
(fn get-cursor-position []
  "gets cursor position, (0, 0) indexed. directly adapted from vimscript version"
  (let [cursor (vim.fn.getpos ".")
        line (vim.fn.getline ".")]
    [(. cursor 1)
     (- (. cursor 2) 1)
     (vim.fn.strdisplaywidth (vim.fn.strpart line 0 (- (. cursor 3) 1)))
     (. cursor 4)]))
(fn replace-tabs [s]
  "replace tabs with <space> * #tabstop. `vim.lsp` seems to think this is okay so i guess it is"
  (string.gsub s "\t" (string.rep " " (vim.lsp.util.get_effective_tabstop))))

; {{{ (fn set-cursor-old [])
; not exactly sure what to do with this yet, the vimscript version has
; some weird logic going on. <plugin/parinfer.vim:150>
; nvim_win_set_cursor() is (1, 0) indexed
; (fn set-cursor-viml [pos] ; TODO
;   "sets cursor position, (0, 0) indexed"
;   (let
;     [cursor [(+ 1 (. pos 1)) (+ 1 (. pos 2))]
;      line (getline (. cursor 1))
;      head (matchstr line (.. ".\\+\\%<" (+ 1 (. cursor 2)) "v"))
;      col (+ 1 (string.len head))]
;     (setpos "." [(. cursor 1) col])))
; (fn set-cursor [pos]
;   "sets cursor position, (0, 0) indexed"
;   (-> (vim.fn.getline (. pos 1))
;       (vim.fn.matchstr (.. ".\\+\\%<" (. pos 2) "v"))
;       (string.len)
;       (+ 1)))
;}}}
