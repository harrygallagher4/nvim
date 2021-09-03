local _2afile_2a = "fnl/dotfiles/module/lf.fnl"
local _2amodule_name_2a = "dotfiles.module.lf"
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
local a, nvim, _ = require("aniseed.core"), require("aniseed.nvim"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["_"] = _
local mod = "lf"
_2amodule_2a["mod"] = mod
a["assoc-in"](vim.g, {"lf#replace_netrw"}, 1)
return a["assoc-in"](vim.g, {"lf#layout"}, {window = {border = "rounded", height = 0.85, highlight = "TelescopeBorder", width = 0.85}})