local _2afile_2a = "fnl/dotfiles/module/treesitter.fnl"
local _2amodule_name_2a = "dotfiles.module.treesitter"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local a, parsers, tsc, _ = require("aniseed.core"), require("nvim-treesitter.parsers"), require("nvim-treesitter.configs"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["parsers"] = parsers
_2amodule_locals_2a["tsc"] = tsc
_2amodule_locals_2a["_"] = _
local parser_configs = parsers.get_parser_configs()
do end (_2amodule_locals_2a)["parser-configs"] = parser_configs
local custom_parsers = {norg = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg", files = {"src/parser.c", "src/scanner.cc"}, branch = "main"}}, norg_meta = {url = "https://github.com/nvim-neorg/tree-sitter-norg-meta", files = {"src/parser.c"}, branch = "main"}, norg_table = {url = "https://github.com/nvim-neorg/tree-sitter-norg-table", files = {"src/parser.c"}, branch = "main"}}
_2amodule_locals_2a["custom-parsers"] = custom_parsers
local function add_parser(name, config)
  return a.assoc(parser_configs, name, config)
end
_2amodule_locals_2a["add-parser"] = add_parser
add_parser("norg", {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg", files = {"src/parser.c", "src/scanner.cc"}, branch = "main"}})
add_parser("norg_meta", {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-meta", files = {"src/parser.c"}, branch = "main"}})
add_parser("norg_table", {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-table", files = {"src/parser.c"}, branch = "main"}})
return tsc.setup({indent = {enable = false}, highlight = {enable = true}, textobjects = {enable = false}, incremental_selection = {enable = false, keymaps = {init_selection = "gnn", node_incremental = "grn", scope_incremental = "grc", node_decremental = "grm"}}, refactor = {navigation = {enable = true, keymaps = {goto_previous_usage = "<c-k>", goto_next_usage = "<c-j>", goto_definition = "gnd", list_definitions = "gnD"}}, highlight_current_scope = {enable = true}, highlight_definitions = {enable = true}, smart_rename = {enable = true, keymaps = {smart_rename = "grr"}}}, rainbow = {enable = true}, playground = {enable = true, updatetime = 10, persist_queries = true}, query_linter = {enable = true, use_virtual_text = true, lint_events = {"BufWrite", "CursorHold"}}})