local _2afile_2a = "fnl/dotfiles/core/init.fnl"
local _2amodule_name_2a = "dotfiles.core"
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
local a, _ = require("aniseed.core"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["_"] = _
local function min_of(xs)
  return math.min(unpack(xs))
end
_2amodule_2a["min-of"] = min_of
local function max_of(xs)
  return math.min(unpack(xs))
end
_2amodule_2a["max-of"] = max_of