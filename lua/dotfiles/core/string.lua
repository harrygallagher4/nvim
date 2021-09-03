local _2afile_2a = "fnl/dotfiles/core/string.fnl"
local _1_
do
  local name_4_auto = "dotfiles.core.string"
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
    return {require("aniseed.core"), require("dotfiles.core"), require("aniseed.string")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", core = "dotfiles.core", str = "aniseed.string"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local core = _local_4_[2]
local str = _local_4_[3]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.core.string"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local splitter
do
  local v_23_auto
  do
    local v_25_auto
    local function splitter0(pat)
      local function _8_(s)
        return str.split(s, pat)
      end
      return _8_
    end
    v_25_auto = splitter0
    _1_["splitter"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["splitter"] = v_23_auto
  splitter = v_23_auto
end
local split
do
  local v_23_auto
  do
    local v_25_auto
    local function split0(pat, _3fs)
      assert((nil ~= pat), string.format("Missing argument %s on %s:%s", "pat", "/Users/harry/.config/nvim/fnl/dotfiles/core/string.fnl", 12))
      if _3fs then
        return str.split(_3fs, pat)
      else
        return splitter(pat)
      end
    end
    v_25_auto = split0
    _1_["split"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["split"] = v_23_auto
  split = v_23_auto
end
local trim_multiline
do
  local v_23_auto
  do
    local v_25_auto
    local function trim_multiline0(s)
      return str.join("\n", a.map(str.trim, split("\n", s)))
    end
    v_25_auto = trim_multiline0
    _1_["trim-multiline"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["trim-multiline"] = v_23_auto
  trim_multiline = v_23_auto
end
local common_indent
do
  local v_23_auto
  do
    local v_25_auto
    local function common_indent0(s)
      local function _10_(_241)
        return string.match(_241, "^(%s+)%S")
      end
      return core["min-of"](a.map(string.len, a.map(_10_, split("\n", s))))
    end
    v_25_auto = common_indent0
    _1_["common-indent"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["common-indent"] = v_23_auto
  common_indent = v_23_auto
end
local trim_leading_spaces
do
  local v_23_auto
  do
    local v_25_auto
    local function trim_leading_spaces0(indent, input)
      local f
      local function _11_(s)
        if string.match(s, ("^" .. string.rep("%s", indent))) then
          return string.sub(s, (1 + indent))
        elseif string.match(s, "^%s+$") then
          return ""
        else
          return s
        end
      end
      f = _11_
      if a["nil?"](input) then
        return f
      else
        return f(input)
      end
    end
    v_25_auto = trim_leading_spaces0
    _1_["trim-leading-spaces"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["trim-leading-spaces"] = v_23_auto
  trim_leading_spaces = v_23_auto
end
local trim_common
do
  local v_23_auto
  do
    local v_25_auto
    local function trim_common0(s)
      local indent = common_indent(s)
      local lines = split("\n", s)
      return str.join("\n", a.map(trim_leading_spaces(indent), lines))
    end
    v_25_auto = trim_common0
    _1_["trim-common"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["trim-common"] = v_23_auto
  trim_common = v_23_auto
end
local multiline_str
do
  local v_23_auto
  do
    local v_25_auto
    local function multiline_str0(s)
      return trim_common(str.join("\n", a.rest(split("\n", s))))
    end
    v_25_auto = multiline_str0
    _1_["multiline-str"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["multiline-str"] = v_23_auto
  multiline_str = v_23_auto
end
return nil