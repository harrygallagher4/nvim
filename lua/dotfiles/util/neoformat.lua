local _2afile_2a = "fnl/dotfiles/util/neoformat.fnl"
local _2amodule_name_2a = "dotfiles.util.neoformat"
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
local a, nvim = require("aniseed.core"), require("aniseed.nvim")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["nvim"] = nvim
local function coerce_to_seq(s)
  local _1_ = s
  local function _2_()
    local x = _1_
    return a["table?"](x)
  end
  if ((nil ~= _1_) and _2_()) then
    local x = _1_
    return x
  else
    local function _3_()
      local x = _1_
      return a["string?"](x)
    end
    if ((nil ~= _1_) and _3_()) then
      local x = _1_
      return {x}
    end
  end
end
_2amodule_locals_2a["coerce-to-seq"] = coerce_to_seq
local function as_seq(_5_)
  local _arg_6_ = _5_
  local k = _arg_6_[1]
  local v = _arg_6_[2]
  return {k, coerce_to_seq(v)}
end
_2amodule_locals_2a["as-seq"] = as_seq
local function set_formatter_21(_7_)
  local _arg_8_ = _7_
  local k = _arg_8_[1]
  local v = _arg_8_[2]
  return a.assoc(vim.g, ("neoformat_enabled_" .. k), v)
end
_2amodule_locals_2a["set-formatter!"] = set_formatter_21
local function init(formatters)
  return a["run!"](set_formatter_21, a["map-indexed"](as_seq, formatters))
end
_2amodule_2a["init"] = init