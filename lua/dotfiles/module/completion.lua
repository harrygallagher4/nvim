local _2afile_2a = "fnl/dotfiles/module/completion.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.completion"
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
    return {require("aniseed.core"), require("compe"), require("luasnip"), require("lspkind"), require("aniseed.nvim")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.maps.macros"] = true}, require = {a = "aniseed.core", compe = "compe", ls = "luasnip", lspkind = "lspkind", nvim = "aniseed.nvim"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local compe = _local_4_[2]
local ls = _local_4_[3]
local lspkind = _local_4_[4]
local nvim = _local_4_[5]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.completion"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
nvim.o.completeopt = "menuone,noselect"
lspkind.init({})
compe.setup({autocomplete = true, debug = false, documentation = true, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, min_length = 1, preselect = "enable", source = {buffer = {dup = false}, calc = false, conjure = true, luasnip = true, neorg = true, nvim_lsp = true, nvim_lua = true, omni = false, path = true, snippets_nvim = false, spell = false, tags = false, treesitter = false, vsnip = false}, source_timeout = 200, throttle_time = 80})
local compe_complete
do
  local v_23_auto = vim.fn["compe#complete"]
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["compe-complete"] = v_23_auto
  compe_complete = v_23_auto
end
local check_back_space
do
  local v_23_auto
  local function check_back_space0()
    local col = (vim.fn.col(".") - 1)
    if ((0 == col) or vim.fn.getline("."):sub(col, col):match("%s")) then
      return true
    else
      return false
    end
  end
  v_23_auto = check_back_space0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["check-back-space"] = v_23_auto
  check_back_space = v_23_auto
end
local tab_complete
do
  local v_23_auto
  local function tab_complete0()
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
  v_23_auto = tab_complete0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["tab-complete"] = v_23_auto
  tab_complete = v_23_auto
end
local shift_tab_complete
do
  local v_23_auto
  local function shift_tab_complete0()
    if (1 == vim.fn.pumvisible()) then
      return "\16"
    elseif ls.jumpable(-1) then
      return "\128\253Sluasnip-jump-prev"
    else
      return "\128kB"
    end
  end
  v_23_auto = shift_tab_complete0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["shift-tab-complete"] = v_23_auto
  shift_tab_complete = v_23_auto
end
map_utils = {s_tab_complete = shift_tab_complete, tab_complete = tab_complete}
vim.keymap.imap({"<tab>", "v:lua.map_utils.tab_complete()", expr = true})
vim.keymap.imap({"<s-tab>", "v:lua.map_utils.s_tab_complete()", expr = true})
vim.keymap.snoremap({"<tab>", "<cmd>lua require'luasnip'.jump(1)<cr>", silent = true})
return vim.keymap.snoremap({"<s-tab>", "<cmd>lua require'luasnip'.jump(-1)<cr>", silent = true})