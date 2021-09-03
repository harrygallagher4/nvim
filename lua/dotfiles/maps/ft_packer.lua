local _2afile_2a = "fnl/dotfiles/maps/ft_packer.fnl"
local _1_
do
  local name_4_auto = "dotfiles.maps.ft_packer"
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
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true, ["dotfiles.maps.macros"] = true}, require = {a = "aniseed.core", nvim = "aniseed.nvim"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local nvim = _local_4_[2]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.maps.ft_packer"
do local _ = ({nil, _1_, nil, {{nil, nil}, nil, nil, nil}})[2] end
local config
do
  local v_23_auto
  do
    local v_25_auto = {cmd = "open"}
    _1_["config"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["config"] = v_23_auto
  config = v_23_auto
end
local updated_pattern
do
  local v_23_auto = "^%W+Updated ([%w%-%.]+)/([%w%-%.]+): (%w+)%.%.(%w+)$"
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["updated-pattern"] = v_23_auto
  updated_pattern = v_23_auto
end
local updated_pattern_branch
do
  local v_23_auto = "^%W+Updated ([%w%-%.]+)/([%w%-%.]+)/[%w%-%.]+: (%w+)%.%.(%w+)$"
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["updated-pattern-branch"] = v_23_auto
  updated_pattern_branch = v_23_auto
end
local repo_pattern
do
  local v_23_auto = "^%W'(%w+)/(%w+)'.*$"
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["repo-pattern"] = v_23_auto
  repo_pattern = v_23_auto
end
local match_str
do
  local v_23_auto
  local function match_str0(s)
    local m = {string.match(s, updated_pattern)}
    if not a["empty?"](m) then
      return unpack(m)
    else
      return string.match(s, updated_pattern_branch)
    end
  end
  v_23_auto = match_str0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["match-str"] = v_23_auto
  match_str = v_23_auto
end
local match_line
do
  local v_23_auto
  local function match_line0()
    return match_str(nvim.get_current_line())
  end
  v_23_auto = match_line0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["match-line"] = v_23_auto
  match_line = v_23_auto
end
local url
do
  local v_23_auto
  local function url0(...)
    if (4 == a.count({...})) then
      return string.format("https://github.com/%s/%s/compare/%s...%s", ...)
    end
  end
  v_23_auto = url0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["url"] = v_23_auto
  url = v_23_auto
end
local open_url_21
do
  local v_23_auto
  local function open_url_210(url0)
    if not a["nil?"](url0) then
      return nvim.command(string.format("silent !%s '%s'", config.cmd, url0))
    end
  end
  v_23_auto = open_url_210
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["open-url!"] = v_23_auto
  open_url_21 = v_23_auto
end
local do_line
do
  local v_23_auto
  local function do_line0()
    return open_url_21(url(match_line()))
  end
  v_23_auto = do_line0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["do-line"] = v_23_auto
  do_line = v_23_auto
end
local init
do
  local v_23_auto
  do
    local v_25_auto
    local function init0()
      return vim.keymap.nnoremap({"o", do_line, buffer = true})
    end
    v_25_auto = init0
    _1_["init"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["init"] = v_23_auto
  init = v_23_auto
end
local a_6_auto = require("aniseed.core")
local s_7_auto = require("aniseed.string")
local v_8_auto = require("aniseed.nvim")
if ((a_6_auto.last(s_7_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_6_auto.last(s_7_auto.split(v_8_auto.buf_get_name(0), "/"))) then
  local _11_
  do
    local m = {match_str(" \226\156\147 oopsie woopsie")}
    if a["empty?"](m) then
      _11_ = nil
    else
      _11_ = m
    end
  end
  local _13_
  do
    local m = {match_str(" \226\156\147 Updated glepnir/lspsaga.nvim: 2bc15f3..2752af4")}
    if a["empty?"](m) then
      _13_ = nil
    else
      _13_ = m
    end
  end
  return url(match_str(" \226\156\147 Updated L3MON4D3/LuaSnip/test: 51a4a92..d076884")), url(match_str(" \226\156\147 Updated L3MON4D3/LuaSnip: 51a4a92..d076884")), url(match_str(" \226\156\147 xxxxxxx L3MON4D3/LuaSnip: 51a4a92..d076884")), open_url_21(url(match_str(" \226\156\147 invalid"))), _11_, _13_, a.count({match_str(" \226\156\147 Updated nvim-treesitter/nvim-treesitter: 2abad14..1d5f928")})
end