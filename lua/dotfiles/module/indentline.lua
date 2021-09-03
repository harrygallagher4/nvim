local _2afile_2a = "fnl/dotfiles/module/indentline.fnl"
local _2amodule_name_2a = "dotfiles.module.indentline"
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
local a, packer, _ = require("aniseed.core"), require("packer"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["packer"] = packer
_2amodule_locals_2a["_"] = _
local gs = {buftype_exclude = {"terminal", "prompt"}, char = "\226\148\130", context_patterns = {"class", "function", "method", "^if", "^while", "^for", "^object", "^table", "block", "arguments", "^attrset$", "^list$", "^let$", "^indented_string$"}, filetype_exclude = {"", "help", "fennel", "packer", "lspinfo", "tsplayground", "query", "scheme", "Trouble"}, show_current_context = true, use_treesitter = true, viewport_buffer = 30}
_2amodule_locals_2a["gs"] = gs
for k, v in pairs(gs) do
  vim.g[("indent_blankline_" .. k)] = v
end
vim.o["list"] = true
vim.o["listchars"] = table.concat({"eol:\226\134\180", "tab:  ", "trail:\226\139\133", "nbsp:_"}, ",")
return packer.loader("indent-blankline.nvim")