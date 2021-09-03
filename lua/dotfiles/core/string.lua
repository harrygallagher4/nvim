local _2afile_2a = "fnl/dotfiles/core/string.fnl"
local _2amodule_name_2a = "dotfiles.core.string"
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
local a, core, str, _ = require("aniseed.core"), require("dotfiles.core"), require("aniseed.string"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["core"] = core
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["_"] = _
local function splitter(pat)
  local function _1_(s)
    return str.split(s, pat)
  end
  return _1_
end
_2amodule_2a["splitter"] = splitter
local split
local function split0(pat, _3fs)
  assert((nil ~= pat), string.format("Missing argument %s on %s:%s", "pat", "/Users/harry/.config/nvim/fnl/dotfiles/core/string.fnl", 12))
  if _3fs then
    return str.split(_3fs, pat)
  else
    return splitter(pat)
  end
end
split = split0
_2amodule_2a["split"] = split
local function trim_multiline(s)
  return str.join("\n", a.map(str.trim, split("\n", s)))
end
_2amodule_2a["trim-multiline"] = trim_multiline
local function common_indent(s)
  local function _3_(_241)
    return string.match(_241, "^(%s+)%S")
  end
  return core["min-of"](a.map(string.len, a.map(_3_, split("\n", s))))
end
_2amodule_2a["common-indent"] = common_indent
local function trim_leading_spaces(indent, input)
  local f
  local function _4_(s)
    if string.match(s, ("^" .. string.rep("%s", indent))) then
      return string.sub(s, (1 + indent))
    elseif string.match(s, "^%s+$") then
      return ""
    else
      return s
    end
  end
  f = _4_
  if a["nil?"](input) then
    return f
  else
    return f(input)
  end
end
_2amodule_2a["trim-leading-spaces"] = trim_leading_spaces
local function trim_common(s)
  local indent = common_indent(s)
  local lines = split("\n", s)
  return str.join("\n", a.map(trim_leading_spaces(indent), lines))
end
_2amodule_2a["trim-common"] = trim_common
local function multiline_str(s)
  return trim_common(str.join("\n", a.rest(split("\n", s))))
end
_2amodule_2a["multiline-str"] = multiline_str