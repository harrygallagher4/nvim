local _2afile_2a = "fnl/dotfiles/module/neoformat.fnl"
local _2amodule_name_2a = "dotfiles.module.neoformat"
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
local neoformat = require("dotfiles.util.neoformat")
do end (_2amodule_locals_2a)["neoformat"] = neoformat
return neoformat.init({html = {"prettier"}, javascript = {"denofmt", "prettier"}, lua = "luaformat", nix = "nixpkgs-fmt", zsh = "shfmt"})