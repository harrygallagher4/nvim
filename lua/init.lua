local _2afile_2a = "fnl/init.fnl"
local _1_
do
  local name_4_auto = "init"
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
    return {require("aniseed.core"), require("lualine"), require("dotfiles.util")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {require = {core = "aniseed.core", lualine = "lualine", util = "dotfiles.util"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local core = _local_4_[1]
local lualine = _local_4_[2]
local util = _local_4_[3]
local _2amodule_2a = _1_
local _2amodule_name_2a = "init"
do local _ = ({nil, _1_, nil, {{}, nil, nil, nil}})[2] end
dotfiles = {module = {}}
require("astronauta.keymap")
nvim.ex.set("termguicolors")
local lualine_opts
do
  local v_23_auto = {inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {"filename"}, lualine_x = {"location"}, lualine_y = {}, lualine_z = {}}, options = {component_separators = {"", ""}, disabled_filetypes = {"Trouble"}, icons_enabled = true, section_separators = {"\238\130\180", "\238\130\182"}, theme = "tokyonight"}, sections = {lualine_a = {"mode"}, lualine_b = {"branch"}, lualine_c = {"filename"}, lualine_x = {"encoding", {"fileformat", icons_enabled = false}, "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}}
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lualine-opts"] = v_23_auto
  lualine_opts = v_23_auto
end
do
  vim.g["tokyonight_style"] = "storm"
  nvim.ex.colorscheme("tokyonight")
  lualine.setup(lualine_opts)
end
-- (do (tset vim.g "material_style" "deep ocean") (tset vim.g "material_contrast" true) ((. (require "material") "set")) (lualine.setup {:options {:theme "material-nvim"}}))
local function _8_(_241)
  local i, j, f = string.match(_241, ".*/(.-)/(.-)/(.-)%.lua")
  local mod = require(string.format("%s.%s.%s", i, j, f))
  do end (_G.dotfiles.module)[f] = mod
  return nil
end
return core["run!"](_8_, util.glob((util["config-path"] .. "/lua/dotfiles/module/*.lua")))