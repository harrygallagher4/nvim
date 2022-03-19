
; todo: investigate the following
; - guard_pattern
; - (sequential_)table_assignment
;

; () delimited
([
  (list)
  (fn)
  (collect)
  (each)
  (for)
  (global)
  (guard_pattern)
  (icollect)
  (lambda)
  (let)
  (local)
  (match)
  (quoted_list)
  (set)
  (var)
  (where_pattern)
] @aligned_indent
  (#set! increment 2))

; [] delimited
; need to test if sequential_table_assignment/pattern include the delimiters
([
  (sequential_table)
  (for_clause)
  (let_clause)
  (parameters)
  (quoted_sequential_table)
  (sequential_table_assignment)
  (sequential_table_binding)
  (sequential_table_pattern)
] @aligned_indent
  (#set! increment 1))

; []-delimited, but the node is just the inside
([
  (iter_bindings)
] @aligned_indent
  (#set! increment 0))

; {} delimited
([
  (table)
  (quoted_table)
  (table_assignment)
  (table_binding)
  (table_pattern)
] @aligned_indent
  (#set! increment 1))



[")" "]" "}"] @indent_end



; ((list . (_) . (_) @arg) @aligned_indent (#set! @arg "type" "aligned_arg") (#set! "delimiter" "aligned_arg"))

; ((list) @aligned_indent (#offset! @aligned_indent 0 1 0 0))
; ((list) @aligned_indent (#set! @aligned_indent "increment" 2))
; ((list) @zero_indent (#set! increment 2))


; ((table) @aligned_indent
 ; (#set! increment 1)
 ; (#set! delimiter "{}"))
; ((sequential_table) @aligned_indent
 ; (#set! increment 1)
 ; (#set! delimiter "[]"))

; [
;   ")"
;   "]"
;   "}"
; ] @indent_end


; @indent @indent_end @branch @ignore
; @dedent @auto
; @aligned_indent
; @zero_indent
; (#set! "delimiter" "()")
; from gdscript/indents ((parameters) @aligned_indent ($set! "delimiter" "()"))

; nodes delimited by ()/[]/{}
; ([
;   (list)
;   (table)
;   (sequential_table)
;   (fn)
;   (collect)
;   (each)
;   (for)
;   (for_clause)
;   (global)
;   (guard_pattern)
;   (icollect)
;   (iter_bindings)
;   (lambda)
;   (let)
;   (let_clause)
;   (local)
;   (match)
;   (parameters)
;   (quoted_list)
;   (quoted_sequential_table)
;   (quoted_table)
;   (sequential_table_assignment)
;   (sequential_table_binding)
;   (sequential_table_pattern)
;   (set)
;   (table_assignment)
;   (table_binding)
;   (table_pattern)
;   (var)
;   (where_pattern)
; ] @aligned_indent
;   (#set! increment 2))

; all tsfnl named nodes
;
; accumulate
; assignment
; binding
; boolean
; collect
; each
; fn
; for
; for_clause
; global
; guard_pattern
; hashfn
; icollect
; iter_bindings
; lambda
; let
; let_clause
; list
; local
; match
; multi_symbol
; multi_symbol_method
; multi_value_assignment
; multi_value_binding
; multi_value_pattern
; parameters
; program
; quote
; quoted_list
; quoted_sequential_table
; quoted_table
; sequential_table
; sequential_table_assignment
; sequential_table_binding
; sequential_table_pattern
; set
; string
; table
; table_assignment
; table_binding
; table_pattern
; unquote
; var
; where_pattern
; comment
; escape_sequence
; nil
; number
; symbol
; vararg
