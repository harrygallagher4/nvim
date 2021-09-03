local _2afile_2a = "fnl/dotfiles/module/bufferline.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.bufferline"
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
    return {require("aniseed.core"), require("bufferline"), require("aniseed.nvim")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true, ["dotfiles.maps.macros"] = true}, require = {a = "aniseed.core", bl = "bufferline", nvim = "aniseed.nvim"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local bl = _local_4_[2]
local nvim = _local_4_[3]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.bufferline"
do local _ = ({nil, _1_, nil, {{nil, nil}, nil, nil, nil}})[2] end
bl.setup({options = {diagnostics = "nvim_lsp", left_trunc_marker = "\239\149\140 ", modified_icon = "\238\141\176 ", right_trunc_marker = "\239\149\147 "}})
vim.keymap.nnoremap({"<leader>]", "<cmd>:BufferLineCycleNext<cr>"})
vim.keymap.nnoremap({"<leader>[", "<cmd>:BufferLineCyclePrev<cr>"})
return vim.keymap.nnoremap({"<leader><leader>o", "<cmd>:BufferLinePick<cr>"})