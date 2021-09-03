local _2afile_2a = "fnl/dotfiles/core/init.fnl"
local _1_
do
  local name_4_auto = "dotfiles.core"
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
    return {require("aniseed.core")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.core"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local min_of
do
  local v_23_auto
  do
    local v_25_auto
    local function min_of0(xs)
      return math.min(unpack(xs))
    end
    v_25_auto = min_of0
    _1_["min-of"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["min-of"] = v_23_auto
  min_of = v_23_auto
end
local max_of
do
  local v_23_auto
  do
    local v_25_auto
    local function max_of0(xs)
      return math.min(unpack(xs))
    end
    v_25_auto = max_of0
    _1_["max-of"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["max-of"] = v_23_auto
  max_of = v_23_auto
end
return nil