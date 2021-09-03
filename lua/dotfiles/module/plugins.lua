local _2afile_2a = "/Users/harry/.config/nvim/fnl/dotfiles/module/plugins.fnl"
local _0_0
do
  local name_0_ = "dotfiles.module.plugins"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local autoload = (require("aniseed.autoload")).autoload
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("aniseed.core"), require("aniseed.nvim"), require("packer")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", nvim = "aniseed.nvim", packer = "packer"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local packer = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "dotfiles.module.plugins"
do local _ = ({nil, _0_0, nil, {{nil}, nil, nil, nil}})[2] end
local mod
do
  local v_0_
  do
    local v_0_0 = "plugins"
    _0_0["mod"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["mod"] = v_0_
  mod = v_0_
end
-- (def packer_spec table: 0x010cef2830)
return nil