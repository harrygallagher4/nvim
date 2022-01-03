local _2afile_2a = "fnl/dotfiles/module/completion.fnl"
local _2amodule_name_2a = "dotfiles.module.completion"
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
local a, compe, ls, lspkind, nvim, _ = require("aniseed.core"), require("compe"), require("luasnip"), require("lspkind"), require("aniseed.nvim"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["compe"] = compe
_2amodule_locals_2a["ls"] = ls
_2amodule_locals_2a["lspkind"] = lspkind
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["_"] = _
nvim.o.completeopt = "menuone,noselect"
lspkind.init({})
compe.setup({enabled = true, autocomplete = true, debug = false, min_length = 1, preselect = "enable", throttle_time = 80, source_timeout = 200, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, documentation = true, source = {path = true, buffer = {dup = false}, calc = false, omni = false, vsnip = false, nvim_lsp = true, nvim_lua = true, spell = false, tags = false, snippets_nvim = false, treesitter = false, conjure = true, luasnip = true, neorg = true}})
local compe_complete = vim.fn["compe#complete"]
_2amodule_locals_2a["compe-complete"] = compe_complete
local function check_back_space()
  local col = (vim.fn.col(".") - 1)
  if ((0 == col) or vim.fn.getline("."):sub(col, col):match("%s")) then
    return true
  else
    return false
  end
end
_2amodule_locals_2a["check-back-space"] = check_back_space
local function tab_complete()
  if (1 == vim.fn.pumvisible()) then
    return "\14"
  elseif ls.jumpable() then
    return "\128\253Sluasnip-jump-next"
  elseif ls.expand_or_jumpable() then
    return "\128\253Sluasnip-expand-or-jump"
  elseif check_back_space() then
    return "\9"
  else
    return compe_complete()
  end
end
_2amodule_locals_2a["tab-complete"] = tab_complete
local function shift_tab_complete()
  if (1 == vim.fn.pumvisible()) then
    return "\16"
  elseif ls.jumpable(-1) then
    return "\128\253Sluasnip-jump-prev"
  else
    return "\128kB"
  end
end
_2amodule_locals_2a["shift-tab-complete"] = shift_tab_complete
map_utils = {tab_complete = tab_complete, s_tab_complete = shift_tab_complete}
vim.keymap.imap({expr = true, "<tab>", "v:lua.map_utils.tab_complete()"})
vim.keymap.imap({expr = true, "<s-tab>", "v:lua.map_utils.s_tab_complete()"})
vim.keymap.snoremap({silent = true, "<tab>", "<cmd>lua require'luasnip'.jump(1)<cr>"})
return vim.keymap.snoremap({silent = true, "<s-tab>", "<cmd>lua require'luasnip'.jump(-1)<cr>"})