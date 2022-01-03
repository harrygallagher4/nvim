local _2afile_2a = "fnl/init.fnl"
local _2amodule_name_2a = "init"
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
local core, theme, util = require("aniseed.core"), require("dotfiles.theme"), require("dotfiles.util")
do end (_2amodule_locals_2a)["core"] = core
_2amodule_locals_2a["theme"] = theme
_2amodule_locals_2a["util"] = util
dotfiles = {module = {}}
require("astronauta.keymap")
theme.init("tokyonight")
local function _1_(_241)
  local i, j, f = string.match(_241, ".*/(.-)/(.-)/(.-)%.lua")
  local mod = require(string.format("%s.%s.%s", i, j, f))
  do end (_G.dotfiles.module)[f] = mod
  return nil
end
return core["run!"](_1_, util.glob((util["config-path"] .. "/lua/dotfiles/module/*.lua")))