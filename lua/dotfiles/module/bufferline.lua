local _2afile_2a = "fnl/dotfiles/module/bufferline.fnl"
local _2amodule_name_2a = "dotfiles.module.bufferline"
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
local a, bl, nvim, _, _0 = require("aniseed.core"), require("bufferline"), require("aniseed.nvim"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["bl"] = bl
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
bl.setup({options = {diagnostics = "nvim_lsp", left_trunc_marker = "\239\149\140 ", modified_icon = "\238\141\176 ", right_trunc_marker = "\239\149\147 "}})
vim.keymap.nnoremap({"<leader>]", "<cmd>:BufferLineCycleNext<cr>"})
vim.keymap.nnoremap({"<leader>[", "<cmd>:BufferLineCyclePrev<cr>"})
return vim.keymap.nnoremap({"<leader><leader>o", "<cmd>:BufferLinePick<cr>"})