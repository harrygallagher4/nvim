local _2afile_2a = "fnl/dotfiles/module/lsp.fnl"
local _2amodule_name_2a = "dotfiles.module.lsp"
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
local a, lsp, lspstatus, nvim, saga, trouble, _, _0 = require("aniseed.core"), require("lspconfig"), require("lsp-status"), require("aniseed.nvim"), require("lspsaga"), require("trouble"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["lsp"] = lsp
_2amodule_locals_2a["lspstatus"] = lspstatus
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["saga"] = saga
_2amodule_locals_2a["trouble"] = trouble
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local lua_runtime_path = a.concat({"lua/?.lua", "lua/?/init.lua"}, vim.split(package.path, ";"))
do end (_2amodule_locals_2a)["lua-runtime-path"] = lua_runtime_path
trouble.setup({auto_preview = false, height = 8})
local function on_attach(client)
  lspstatus.on_attach(client)
  vim.keymap.nnoremap({buffer = true, "K", vim.lsp.buf.hover})
  vim.keymap.nnoremap({buffer = true, "<c-l>", vim.lsp.buf.signature_help})
  vim.keymap.inoremap({buffer = true, "<c-l>", vim.lsp.buf.signature_help})
  vim.keymap.nnoremap({buffer = true, "gd", vim.lsp.buf.definition})
  vim.keymap.nnoremap({buffer = true, "gr", vim.lsp.buf.references})
  vim.keymap.nnoremap({buffer = true, "gD", vim.lsp.buf.declaration})
  vim.keymap.nnoremap({buffer = true, "gi", vim.lsp.buf.implementation})
  vim.keymap.nnoremap({buffer = true, "<leader>r", vim.lsp.buf.rename})
  vim.keymap.nnoremap({buffer = true, "<leader>ca", vim.lsp.buf.code_action})
  vim.keymap.nnoremap({buffer = true, "<leader>d", vim.lsp.diagnostic.show_line_diagnostics})
  vim.keymap.nnoremap({buffer = true, "[d", vim.lsp.diagnostic.goto_prev})
  vim.keymap.nnoremap({buffer = true, "d]", vim.lsp.diagnostic.goto_next})
  vim.keymap.nnoremap({buffer = true, "<leader>q", vim.lsp.diagnostic.set_loclist})
  if client.resolved_capabilities.document_formatting then
    vim.keymap.nnoremap({buffer = true, "<leader>f", vim.lsp.buf.formatting})
  else
  end
  if client.resolved_capabilities.document_range_formatting then
    return vim.keymap.vnoremap({buffer = true, "<leader>f", vim.lsp.buf.range_formatting})
  else
    return nil
  end
end
_2amodule_locals_2a["on_attach"] = on_attach
local function setup(server, config)
  return a["get-in"](lsp, {server, "setup"})(config)
end
_2amodule_locals_2a["setup"] = setup
lspstatus.register_progress()
saga.init_lsp_saga()
setup("svelte", {on_attach = on_attach})
setup("denols", {on_attach = on_attach})
setup("tsserver", {on_attach = on_attach})
setup("clojure_lsp", {on_attach = on_attach})
setup("jsonls", {on_attach = on_attach})
setup("bashls", {on_attach = on_attach})
setup("yamlls", {on_attach = on_attach})
setup("vimls", {on_attach = on_attach})
return setup("sumneko_lua", {on_attach = on_attach, settings = {Lua = {runtime = {version = "LuaJIT", path = lua_runtime_path}, diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_get_runtime_file("", true)}, telemetry = {enable = false}}}})