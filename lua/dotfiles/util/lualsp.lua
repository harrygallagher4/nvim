local _2afile_2a = "fnl/dotfiles/util/lualsp.fnl"
local _2amodule_name_2a = "dotfiles.util.lualsp"
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
local a, luadev, nvim = require("aniseed.core"), require("lua-dev"), require("aniseed.nvim")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["luadev"] = luadev
_2amodule_locals_2a["nvim"] = nvim
local sumneko_root = (nvim.fn.stdpath("cache") .. "/lsp/lua/")
do end (_2amodule_2a)["sumneko-root"] = sumneko_root
local function p(...)
  return (sumneko_root .. ...)
end
_2amodule_locals_2a["p"] = p
local bin = p("bin/macOS/lua-language-server")
do end (_2amodule_2a)["bin"] = bin
local cmd = {bin, "-E"}
_2amodule_2a["cmd"] = cmd
local ldconfig = {cmd = cmd}
_2amodule_locals_2a["ldconfig"] = ldconfig
local function setup(...)
  return luadev.setup({library = {vimruntime = true, types = true, plugins = true}, lspconfig = a.merge(ldconfig, ...)})
end
_2amodule_2a["setup"] = setup