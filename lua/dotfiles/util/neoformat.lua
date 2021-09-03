local _2afile_2a = "fnl/dotfiles/util/neoformat.fnl"
local _1_
do
  local name_4_auto = "dotfiles.util.neoformat"
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
    _1_["aniseed/local-fns"] = {require = {a = "aniseed.core", nvim = "aniseed.nvim"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local nvim = _local_4_[2]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.util.neoformat"
do local _ = ({nil, _1_, nil, {{}, nil, nil, nil}})[2] end
local coerce_to_seq
do
  local v_23_auto
  local function coerce_to_seq0(s)
    local _8_ = s
    local function _9_()
      local x = _8_
      return a["table?"](x)
    end
    if ((nil ~= _8_) and _9_()) then
      local x = _8_
      return x
    else
      local function _10_()
        local x = _8_
        return a["string?"](x)
      end
      if ((nil ~= _8_) and _10_()) then
        local x = _8_
        return {x}
      end
    end
  end
  v_23_auto = coerce_to_seq0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["coerce-to-seq"] = v_23_auto
  coerce_to_seq = v_23_auto
end
local as_seq
do
  local v_23_auto
  local function as_seq0(_12_)
    local _arg_13_ = _12_
    local k = _arg_13_[1]
    local v = _arg_13_[2]
    return {k, coerce_to_seq(v)}
  end
  v_23_auto = as_seq0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["as-seq"] = v_23_auto
  as_seq = v_23_auto
end
local set_formatter_21
do
  local v_23_auto
  local function set_formatter_210(_14_)
    local _arg_15_ = _14_
    local k = _arg_15_[1]
    local v = _arg_15_[2]
    return a.assoc(vim.g, ("neoformat_enabled_" .. k), v)
  end
  v_23_auto = set_formatter_210
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["set-formatter!"] = v_23_auto
  set_formatter_21 = v_23_auto
end
local init
do
  local v_23_auto
  do
    local v_25_auto
    local function init0(formatters)
      return a["run!"](set_formatter_21, a["map-indexed"](as_seq, formatters))
    end
    v_25_auto = init0
    _1_["init"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["init"] = v_23_auto
  init = v_23_auto
end
return nil