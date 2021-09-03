local _2afile_2a = "fnl/dotfiles/module/fzf.fnl"
local _2amodule_name_2a = "dotfiles.module.fzf"
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
local a, nvim = require("aniseed.core"), require("aniseed.nvim")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["nvim"] = nvim
nvim.g.fzf_layout = {window = {border = "sharp", height = 0.6, highlight = "VertSplit", width = 0.9}}
nvim.g.fzf_action = {["ctrl-i"] = "vsplit", ["ctrl-o"] = "split"}
return nil