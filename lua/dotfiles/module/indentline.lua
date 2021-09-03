local _2afile_2a = "fnl/dotfiles/module/indentline.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.indentline"
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
    return {require("aniseed.core"), require("packer")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", packer = "packer"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local packer = _local_4_[2]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.indentline"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local gs
do
  local v_23_auto = {buftype_exclude = {"terminal", "prompt"}, char = "\226\148\130", context_patterns = {"class", "function", "method", "^if", "^while", "^for", "^object", "^table", "block", "arguments", "^attrset$", "^list$", "^let$", "^indented_string$"}, filetype_exclude = {"", "help", "fennel", "packer", "lspinfo", "tsplayground", "query", "scheme", "Trouble"}, show_current_context = true, use_treesitter = true, viewport_buffer = 30}
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["gs"] = v_23_auto
  gs = v_23_auto
end
for k, v in pairs(gs) do
  vim.g[("indent_blankline_" .. k)] = v
end
vim.o["list"] = true
vim.o["listchars"] = table.concat({"eol:\226\134\180", "tab:  ", "trail:\226\139\133", "nbsp:_"}, ",")
return packer.loader("indent-blankline.nvim")