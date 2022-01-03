(module dotfiles.module.treesitter
  {require {a aniseed.core
            tsc nvim-treesitter.configs
            parsers nvim-treesitter.parsers}
   require-macros [dotfiles.macros]})

(def- parser-configs (parsers.get_parser_configs))
(def- custom-parsers
  {:norg
   {:install_info
    {:url "https://github.com/nvim-neorg/tree-sitter-norg"
     :files ["src/parser.c" "src/scanner.cc"]
     :branch "main"}}
   :norg_meta
   {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
    :files ["src/parser.c"]
    :branch "main"}
   :norg_table
   {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
    :files ["src/parser.c"]
    :branch "main"}})

(defn- add-parser [name config]
  (a.assoc parser_configs name config))

; (require "dotfiles.etc.neorg_ts_setup")
(add-parser :norg
  {:install_info
   {:url "https://github.com/nvim-neorg/tree-sitter-norg"
    :files ["src/parser.c" "src/scanner.cc"]
    :branch "main"}})
(add-parser :norg_meta
  {:install_info
   {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
    :files ["src/parser.c"]
    :branch "main"}})
(add-parser :norg_table
  {:install_info
   {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
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
   :refactor {:navigation {:enable true
                           :keymaps
                           {:goto_previous_usage "<c-k>"
                            :goto_next_usage "<c-j>"
                            :goto_definition "gnd"
                            :list_definitions "gnD"}}
              :highlight_current_scope {:enable true}
              :highlight_definitions {:enable true}
              :smart_rename {:enable true
                             :keymaps
                             {:smart_rename "grr"}}}
   :rainbow {:enable true}
   :playground {:enable true
                :updatetime 10
                :persist_queries true}
   :query_linter {:enable true
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
