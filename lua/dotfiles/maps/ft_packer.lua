local _2afile_2a = "fnl/dotfiles/maps/ft_packer.fnl"
local _2amodule_name_2a = "dotfiles.maps.ft_packer"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local a, nvim, _, _0 = require("aniseed.core"), require("aniseed.nvim"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local config = {cmd = "open"}
_2amodule_2a["config"] = config
local updated_pattern = "^%W+Updated ([%w%-%.]+)/([%w%-%.]+): (%w+)%.%.(%w+)$"
_2amodule_locals_2a["updated-pattern"] = updated_pattern
local updated_pattern_branch = "^%W+Updated ([%w%-%.]+)/([%w%-%.]+)/[%w%-%.]+: (%w+)%.%.(%w+)$"
_2amodule_locals_2a["updated-pattern-branch"] = updated_pattern_branch
local repo_pattern = "^%W'(%w+)/(%w+)'.*$"
_2amodule_locals_2a["repo-pattern"] = repo_pattern
local function match_str(s)
  local m = {string.match(s, updated_pattern)}
  if not a["empty?"](m) then
    return unpack(m)
  else
    return string.match(s, updated_pattern_branch)
  end
end
_2amodule_locals_2a["match-str"] = match_str
local function match_line()
  return match_str(nvim.get_current_line())
end
_2amodule_locals_2a["match-line"] = match_line
local function url(...)
  if (4 == a.count({...})) then
    return string.format("https://github.com/%s/%s/compare/%s...%s", ...)
  else
    return nil
  end
end
_2amodule_locals_2a["url"] = url
local function open_url_21(url0)
  if not a["nil?"](url0) then
    return nvim.command(string.format("silent !%s '%s'", config.cmd, url0))
  else
    return nil
  end
end
_2amodule_locals_2a["open-url!"] = open_url_21
local function do_line()
  return open_url_21(url(match_line()))
end
_2amodule_locals_2a["do-line"] = do_line
local function init()
  return vim.keymap.nnoremap({buffer = true, "o", do_line})
end
_2amodule_2a["init"] = init
local a_2_auto = require("aniseed.core")
local s_3_auto = require("aniseed.string")
local v_4_auto = require("aniseed.nvim")
if ((a_2_auto.last(s_3_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_2_auto.last(s_3_auto.split(v_4_auto.buf_get_name(0), "/"))) then
  local _4_
  do
    local m = {match_str(" \226\156\147 oopsie woopsie")}
    if a["empty?"](m) then
      _4_ = nil
    else
      _4_ = m
    end
  end
  local _6_
  do
    local m = {match_str(" \226\156\147 Updated glepnir/lspsaga.nvim: 2bc15f3..2752af4")}
    if a["empty?"](m) then
      _6_ = nil
    else
      _6_ = m
    end
  end
  return url(match_str(" \226\156\147 Updated L3MON4D3/LuaSnip/test: 51a4a92..d076884")), url(match_str(" \226\156\147 Updated L3MON4D3/LuaSnip: 51a4a92..d076884")), url(match_str(" \226\156\147 xxxxxxx L3MON4D3/LuaSnip: 51a4a92..d076884")), open_url_21(url(match_str(" \226\156\147 invalid"))), _4_, _6_, a.count({match_str(" \226\156\147 Updated nvim-treesitter/nvim-treesitter: 2abad14..1d5f928")})
else
  return nil
end