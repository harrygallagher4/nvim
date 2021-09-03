local _2afile_2a = "fnl/dotfiles/module/lf.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.lf"
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
    return {require("aniseed.core"), require("aniseed.nvim")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", nvim = "aniseed.nvim"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local nvim = _local_4_[2]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.lf"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local mod
do
  local v_23_auto
  do
    local v_25_auto = "lf"
    _1_["mod"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["mod"] = v_23_auto
  mod = v_23_auto
end
a["assoc-in"](vim.g, {"lf#replace_netrw"}, 1)
return a["assoc-in"](vim.g, {"lf#layout"}, {window = {border = "rounded", height = 0.85, highlight = "TelescopeBorder", width = 0.85}})