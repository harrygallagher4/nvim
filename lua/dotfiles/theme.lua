local _2afile_2a = "fnl/dotfiles/theme.fnl"
local _2amodule_name_2a = "dotfiles.theme"
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
local a, lualine, _ = require("aniseed.core"), require("lualine"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["lualine"] = lualine
_2amodule_locals_2a["_"] = _
vim.g["tokyonight_style"] = "storm"
vim.g["material_style"] = "deep ocean"
vim.g["material_contrast"] = true
local theme = (vim.g.theme or "tokyonight")
do end (_2amodule_locals_2a)["theme"] = theme
local lualine_themes = {none = "none"}
_2amodule_locals_2a["lualine-themes"] = lualine_themes
local function lualine_theme(theme0)
  return (lualine_themes[theme0] or theme0)
end
_2amodule_locals_2a["lualine-theme"] = lualine_theme
local function lualine_opts(theme0)
  return {options = {component_separators = {"", ""}, disabled_filetypes = {"Trouble"}, icons_enabled = true, section_separators = {left = "\238\130\180", right = "\238\130\182"}, theme = lualine_theme(theme0)}, sections = {lualine_a = {"mode"}, lualine_b = {"branch"}, lualine_c = {"filename"}, lualine_x = {"encoding", {icons_enabled = false, "fileformat"}, "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {"filename"}, lualine_x = {"location"}, lualine_y = {}, lualine_z = {}}}
end
_2amodule_locals_2a["lualine-opts"] = lualine_opts
local function init(theme0)
  nvim.ex.set("termguicolors")
  nvim.ex.colorscheme("tokyonight")
  return lualine.setup(lualine_opts(theme0))
end
_2amodule_2a["init"] = init