local _2afile_2a = "fnl/init.fnl"
local _2amodule_name_2a = "init"
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
local core, lualine, util = require("aniseed.core"), require("lualine"), require("dotfiles.util")
do end (_2amodule_locals_2a)["core"] = core
_2amodule_locals_2a["lualine"] = lualine
_2amodule_locals_2a["util"] = util
dotfiles = {module = {}}
require("astronauta.keymap")
nvim.ex.set("termguicolors")
local lualine_opts = {inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {"filename"}, lualine_x = {"location"}, lualine_y = {}, lualine_z = {}}, options = {component_separators = {"", ""}, disabled_filetypes = {"Trouble"}, icons_enabled = true, section_separators = {"\238\130\180", "\238\130\182"}, theme = "tokyonight"}, sections = {lualine_a = {"mode"}, lualine_b = {"branch"}, lualine_c = {"filename"}, lualine_x = {"encoding", {"fileformat", icons_enabled = false}, "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}}
_2amodule_locals_2a["lualine-opts"] = lualine_opts
do
  vim.g["tokyonight_style"] = "storm"
  nvim.ex.colorscheme("tokyonight")
  lualine.setup(lualine_opts)
end
-- (do (tset vim.g "material_style" "deep ocean") (tset vim.g "material_contrast" true) ((. (require "material") "set")) (lualine.setup {:options {:theme "material-nvim"}}))
local function _1_(_241)
  local i, j, f = string.match(_241, ".*/(.-)/(.-)/(.-)%.lua")
  local mod = require(string.format("%s.%s.%s", i, j, f))
  do end (_G.dotfiles.module)[f] = mod
  return nil
end
return core["run!"](_1_, util.glob((util["config-path"] .. "/lua/dotfiles/module/*.lua")))