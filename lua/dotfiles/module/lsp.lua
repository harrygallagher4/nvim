local _2afile_2a = "fnl/dotfiles/module/lsp.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.lsp"
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
    return {require("aniseed.core"), require("lspconfig/configs"), require("lspconfig"), require("lsp_signature"), require("lsp-status"), require("dotfiles.util.lualsp"), require("navigator"), require("aniseed.nvim"), require("lspsaga"), require("trouble"), require("lspconfig/util")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true, ["dotfiles.maps.macros"] = true}, require = {a = "aniseed.core", configs = "lspconfig/configs", lsp = "lspconfig", lspsig = "lsp_signature", lspstatus = "lsp-status", lualsp = "dotfiles.util.lualsp", navigator = "navigator", nvim = "aniseed.nvim", saga = "lspsaga", trouble = "trouble", util = "lspconfig/util"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local trouble = _local_4_[10]
local util = _local_4_[11]
local configs = _local_4_[2]
local lsp = _local_4_[3]
local lspsig = _local_4_[4]
local lspstatus = _local_4_[5]
local lualsp = _local_4_[6]
local navigator = _local_4_[7]
local nvim = _local_4_[8]
local saga = _local_4_[9]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.lsp"
do local _ = ({nil, _1_, nil, {{nil, nil}, nil, nil, nil}})[2] end
trouble.setup({auto_preview = false, height = 8})
local on_attach
do
  local v_23_auto
  local function on_attach0(client)
    lspstatus.on_attach(client)
    vim.keymap.nnoremap({"K", vim.lsp.buf.hover, buffer = true})
    vim.keymap.nnoremap({"<c-l>", vim.lsp.buf.signature_help, buffer = true})
    vim.keymap.inoremap({"<c-l>", vim.lsp.buf.signature_help, buffer = true})
    vim.keymap.nnoremap({"gd", vim.lsp.buf.definition, buffer = true})
    vim.keymap.nnoremap({"gr", vim.lsp.buf.references, buffer = true})
    vim.keymap.nnoremap({"gD", vim.lsp.buf.declaration, buffer = true})
    vim.keymap.nnoremap({"gi", vim.lsp.buf.implementation, buffer = true})
    vim.keymap.nnoremap({"<leader>r", vim.lsp.buf.rename, buffer = true})
    vim.keymap.nnoremap({"<leader>ca", vim.lsp.buf.code_action, buffer = true})
    vim.keymap.nnoremap({"<leader>d", vim.lsp.diagnostic.show_line_diagnostics, buffer = true})
    vim.keymap.nnoremap({"[d", vim.lsp.diagnostic.goto_prev, buffer = true})
    vim.keymap.nnoremap({"d]", vim.lsp.diagnostic.goto_next, buffer = true})
    vim.keymap.nnoremap({"<leader>q", vim.lsp.diagnostic.set_loclist, buffer = true})
    if client.resolved_capabilities.document_formatting then
      vim.keymap.nnoremap({"<leader>f", vim.lsp.buf.formatting, buffer = true})
    end
    if client.resolved_capabilities.document_range_formatting then
      return vim.keymap.vnoremap({"<leader>f", vim.lsp.buf.range_formatting, buffer = true})
    end
  end
  v_23_auto = on_attach0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["on_attach"] = v_23_auto
  on_attach = v_23_auto
end
local setup
do
  local v_23_auto
  local function setup0(server, config)
    return a["get-in"](lsp, {server, "setup"})(config)
  end
  v_23_auto = setup0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["setup"] = v_23_auto
  setup = v_23_auto
end
lspstatus.register_progress()
saga.init_lsp_saga()
setup("rnix", {on_attach = on_attach})
setup("svelte", {on_attach = on_attach})
setup("denols", {on_attach = on_attach})
setup("tsserver", {on_attach = on_attach})
setup("clojure_lsp", {on_attach = on_attach})
setup("jsonls", {on_attach = on_attach})
setup("bashls", {on_attach = on_attach})
setup("yamlls", {on_attach = on_attach})
setup("vimls", {on_attach = on_attach})
return setup("sumneko_lua", lualsp.setup({on_attach = on_attach}))