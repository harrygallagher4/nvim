(module dotfiles.module.treesitter
  {require
   {a aniseed.core
    str dotfiles.util.string
    ts nvim-treesitter
    tsc nvim-treesitter.configs
    tsq nvim-treesitter.query
    parsers nvim-treesitter.parsers}})

(def- parser-configs (parsers.get_parser_configs))
(defn- add-parser [name config]
  (a.assoc parser-configs name config))
(def- custom-parsers
  {:norg
   {:install_info
    {:url "https://github.com/nvim-neorg/tree-sitter-norg"
     :files ["src/parser.c" "src/scanner.cc"]
     :branch "main"}}
   :norg_meta
   {:install_info
    {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
     :files ["src/parser.c"]
     :branch "main"}}
   :norg_table
   {:install_info
    {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
     :files ["src/parser.c"]
     :branch "main"}}})

(each [name config (pairs custom-parsers)]
  (add-parser name config))

;
; For some reason nvim-treesitter can't use macOS's
; built-in compilers
;
(defonce- default-compilers (a.rest (. (require :nvim-treesitter.install) :compilers)))
(def- okay-compilers
  (->> default-compilers
       (a.map    vim.fn.exepath)
       (a.filter #(< 0 (string.len $)))
       (a.filter #(a.nil? (string.find $ "/usr/bin")))
       (a.map    #(a.last (str.split "/" $)))))
(tset (require :nvim-treesitter.install) :compilers okay-compilers)


(ts.define_modules
  {:harryg
   {:highlight_scope {:module_path :dotfiles.plugin.ts-highlight-scope
                      :enable false
                      :disable []
                      :is_supported tsq.has_locals}}})


(tsc.setup
  {:harryg {:highlight_scope {:enable true}}
   :indent {:enable true}
   :highlight {:enable true}
   :textobjects {:enable false}
   :incremental_selection {:enable true
                           :keymaps
                           {:init_selection "g<space>"
                            :node_incremental "gno"
                            :scope_incremental "gns"
                            :node_decremental "gni"}}
   :refactor {:navigation {:enable true
                           :keymaps
                           {:goto_previous_usage "<c-k>"
                            :goto_next_usage "<c-j>"
                            :goto_definition "gd"
                            :list_definitions "gb"}}
              :highlight_current_scope {:enable false}
              :highlight_definitions {:enable true}
              :smart_rename {:enable true
                             :keymaps
                             {:smart_rename "gR"}}}
   :rainbow {:enable false}
   :playground {:enable true
                :updatetime 10
                :persist_queries true}
   :query_linter {:enable true
                  :use_virtual_text true
                  :lint_events [:BufWrite :CursorHold]}})

