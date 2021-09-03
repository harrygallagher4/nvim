local _2afile_2a = "fnl/dotfiles/module/lsp.fnl"
local _2amodule_name_2a = "dotfiles.module.lsp"
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
local a, configs, lsp, lspsig, lspstatus, lualsp, navigator, nvim, saga, trouble, util, _, _0 = require("aniseed.core"), require("lspconfig/configs"), require("lspconfig"), require("lsp_signature"), require("lsp-status"), require("dotfiles.util.lualsp"), require("navigator"), require("aniseed.nvim"), require("lspsaga"), require("trouble"), require("lspconfig/util"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["configs"] = configs
_2amodule_locals_2a["lsp"] = lsp
_2amodule_locals_2a["lspsig"] = lspsig
_2amodule_locals_2a["lspstatus"] = lspstatus
_2amodule_locals_2a["lualsp"] = lualsp
_2amodule_locals_2a["navigator"] = navigator
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["saga"] = saga
_2amodule_locals_2a["trouble"] = trouble
_2amodule_locals_2a["util"] = util
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
trouble.setup({auto_preview = false, height = 8})
local function on_attach(client)
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
_2amodule_locals_2a["on_attach"] = on_attach
local function setup(server, config)
  return a["get-in"](lsp, {server, "setup"})(config)
end
_2amodule_locals_2a["setup"] = setup
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