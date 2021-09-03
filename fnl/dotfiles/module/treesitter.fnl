(module dotfiles.module.treesitter
  {require {a aniseed.core
            tsc nvim-treesitter.configs
            parsers nvim-treesitter.parsers}
   require-macros [dotfiles.macros]})

(def- parser-configs (parsers.get_parser_configs))

(defn- add-parser [name config]
  (a.assoc parser_configs name config))

; (require "dotfiles.etc.neorg_ts_setup")
(add-parser :norg
  {:install_info
   {:url "https://github.com/vhyrro/tree-sitter-norg"
    :files ["src/parser.c"]
    :branch "main"}})

(tsc.setup
  {:indent {:enable false}
   ; :ensure_installed "all"
   :highlight {:enable true}
   :textobjects {:enable false}
   :incremental_selection {:enable false
                           :keymaps
                           {:init_selection "gnn"
                            :node_incremental "grn"
                            :scope_incremental "grc"
                            :node_decremental "grm"}}
   :refactor {:navigation {:enable false
                           :keymaps
                           {:goto_previous_usage "<c-k>"
                            :goto_next_usage "<c-j>"
                            :goto_definition "gnd"
                            :list_definitions "gnD"}}
              :highlight_current_scope {:enable false}
              :highlight_definitions {:enable false}
              :smart_rename {:enable false
                             :keymaps
                             {:smart_rename "grr"}}}
   :rainbow {:enable false}
   :playground {:enable false
                :updatetime 10
                :persist_queries true}
   :query_linter {:enable false
                  :use_virtual_text true
                  :lint_events [:BufWrite :CursorHold]}})

; (add-parser :fennel
;   {:install_info
;    {:url "~/Projects/tree-sitter/grammars/tree-sitter-fennel"
;     :files ["src/tree_sitter/parser.h" "src/parser.c"]}})

; (tsc.setup
;   {:playground
;    {:enable true
;     :updatetime 25
;     :persist_queries false}
;    :query_linter
;    {:enable false
;     :use_virtual_text true
;     :lint_events [:BufWrite :CursorHold]}})

; (get-in parser_configs [:fennel])
; :ensure_installed "all"
