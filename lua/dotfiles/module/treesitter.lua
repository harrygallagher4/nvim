local _2afile_2a = "fnl/dotfiles/module/treesitter.fnl"
local _2amodule_name_2a = "dotfiles.module.treesitter"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["_LOCALS"] = {}
  _2amodule_locals_2a = (_2amodule_2a)._LOCALS
end
local a, parsers, tsc, _ = require("aniseed.core"), require("nvim-treesitter.parsers"), require("nvim-treesitter.configs"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["parsers"] = parsers
_2amodule_locals_2a["tsc"] = tsc
_2amodule_locals_2a["_"] = _
local parser_configs = parsers.get_parser_configs()
do end (_2amodule_locals_2a)["parser-configs"] = parser_configs
local function add_parser(name, config)
  return a.assoc(parser_configs, name, config)
end
_2amodule_locals_2a["add-parser"] = add_parser
add_parser("norg", {install_info = {branch = "main", files = {"src/parser.c"}, url = "https://github.com/vhyrro/tree-sitter-norg"}})
return tsc.setup({highlight = {enable = true}, incremental_selection = {enable = false, keymaps = {init_selection = "gnn", node_decremental = "grm", node_incremental = "grn", scope_incremental = "grc"}}, indent = {enable = false}, playground = {enable = false, persist_queries = true, updatetime = 10}, query_linter = {enable = false, lint_events = {"BufWrite", "CursorHold"}, use_virtual_text = true}, rainbow = {enable = false}, refactor = {highlight_current_scope = {enable = false}, highlight_definitions = {enable = false}, navigation = {enable = false, keymaps = {goto_definition = "gnd", goto_next_usage = "<c-j>", goto_previous_usage = "<c-k>", list_definitions = "gnD"}}, smart_rename = {enable = false, keymaps = {smart_rename = "grr"}}}, textobjects = {enable = false}})