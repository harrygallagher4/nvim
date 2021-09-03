local _2afile_2a = "fnl/dotfiles/module/treesitter.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.treesitter"
  local module_5_auto
  do
    local x_6_auto = _G.package.loaded[name_4_auto]
    if ("table" == type(x_6_auto)) then
      module_5_auto = x_6_auto
    else
      module_5_auto = {}
    end
  end
  module_5_auto["aniseed/module"] = name_4_auto
  module_5_auto["aniseed/locals"] = ((module_5_auto)["aniseed/locals"] or {})
  do end (module_5_auto)["aniseed/local-fns"] = ((module_5_auto)["aniseed/local-fns"] or {})
  do end (_G.package.loaded)[name_4_auto] = module_5_auto
  _1_ = module_5_auto
end
local autoload
local function _3_(...)
  return (require("aniseed.autoload")).autoload(...)
end
autoload = _3_
local function _6_(...)
  local ok_3f_21_auto, val_22_auto = nil, nil
  local function _5_()
    return {require("aniseed.core"), require("nvim-treesitter.parsers"), require("nvim-treesitter.configs")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", parsers = "nvim-treesitter.parsers", tsc = "nvim-treesitter.configs"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local parsers = _local_4_[2]
local tsc = _local_4_[3]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.treesitter"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local parser_configs
do
  local v_23_auto = parsers.get_parser_configs()
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["parser-configs"] = v_23_auto
  parser_configs = v_23_auto
end
local add_parser
do
  local v_23_auto
  local function add_parser0(name, config)
    return a.assoc(parser_configs, name, config)
  end
  v_23_auto = add_parser0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["add-parser"] = v_23_auto
  add_parser = v_23_auto
end
add_parser("norg", {install_info = {branch = "main", files = {"src/parser.c"}, url = "https://github.com/vhyrro/tree-sitter-norg"}})
return tsc.setup({highlight = {enable = true}, incremental_selection = {enable = false, keymaps = {init_selection = "gnn", node_decremental = "grm", node_incremental = "grn", scope_incremental = "grc"}}, indent = {enable = false}, playground = {enable = false, persist_queries = true, updatetime = 10}, query_linter = {enable = false, lint_events = {"BufWrite", "CursorHold"}, use_virtual_text = true}, rainbow = {enable = false}, refactor = {highlight_current_scope = {enable = false}, highlight_definitions = {enable = false}, navigation = {enable = false, keymaps = {goto_definition = "gnd", goto_next_usage = "<c-j>", goto_previous_usage = "<c-k>", list_definitions = "gnD"}}, smart_rename = {enable = false, keymaps = {smart_rename = "grr"}}}, textobjects = {enable = false}})