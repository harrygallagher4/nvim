local _2afile_2a = "fnl/dotfiles/util.fnl"
local _2amodule_name_2a = "dotfiles.util"
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
local a, env, it, nvim, nvu, preload, _ = require("aniseed.core"), require("aniseed.env"), require("plenary.iterators"), require("aniseed.nvim"), require("aniseed.nvim.util"), require("plenary.reload"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["env"] = env
_2amodule_locals_2a["it"] = it
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["nvu"] = nvu
_2amodule_locals_2a["preload"] = preload
_2amodule_locals_2a["_"] = _
local config_path = nvim.fn.stdpath("config")
do end (_2amodule_2a)["config-path"] = config_path
local unpack = (rawget(_G, "unpack") or table.unpack)
do end (_2amodule_2a)["unpack"] = unpack
local function slice(t, s, e)
  return {unpack(t, s, e)}
end
_2amodule_2a["slice"] = slice
local function zipmap(...)
  return it.zip(...):tomap()
end
_2amodule_2a["zipmap"] = zipmap
local function even_key(_1_)
  local _arg_2_ = _1_
  local x = _arg_2_[1]
  local y = _arg_2_[2]
  if (0 == (x % 2)) then
    return y
  end
end
_2amodule_2a["even-key"] = even_key
local function odd_key(_4_)
  local _arg_5_ = _4_
  local x = _arg_5_[1]
  local y = _arg_5_[2]
  if not (0 == (x % 2)) then
    return y
  end
end
_2amodule_2a["odd-key"] = odd_key
local function split_seq(t)
  local odd = a["map-indexed"](odd_key, t)
  local even = a["map-indexed"](even_key, t)
  local function _7_()
    if (#odd == #even) then
      return {odd, even}
    else
      return {a.butlast(odd), even}
    end
  end
  return unpack(_7_())
end
_2amodule_2a["split-seq"] = split_seq
local function expand(path)
  return nvim.fn.expand(path)
end
_2amodule_2a["expand"] = expand
local function glob(path)
  return nvim.fn.glob(path, true, true, true)
end
_2amodule_2a["glob"] = glob
local function exists_3f(path)
  return (nvim.fn.filereadable(path) == 1)
end
_2amodule_2a["exists?"] = exists_3f
local function lua_file(path)
  return nvim.ex.luafile(path)
end
_2amodule_2a["lua-file"] = lua_file
local function oset_arg(x, y, z)
  if z then
    return (x .. y .. z)
  elseif y then
    return (x .. "=" .. y)
  else
    return x
  end
end
_2amodule_locals_2a["oset-arg"] = oset_arg
local function oset_21(x, y, z)
  return nvim.ex.set(oset_arg(x, y, z))
end
_2amodule_2a["oset!"] = oset_21
local function memoize(f)
  local results = {}
  local function memoize_internal(...)
    local key = a["pr-str"]({...})
    local result = a.get(results, key)
    if not result then
      local value = f(...)
      do end (results)[key] = value
      return value
    else
      return result
    end
  end
  return memoize_internal
end
_2amodule_2a["memoize"] = memoize
local function print_inspect(o)
  print(vim.inspect(o))
  return o
end
_2amodule_2a["print_inspect"] = print_inspect
_G["pr"] = print_inspect
if not a["nil?"](preload.reload_module) then
  local function _10_(m)
    preload.reload_module(m)
    return require(m)
  end
  _G["reload"] = _10_
end
local function lspstatus(bufnr)
  return a.get(a.first(vim.lsp.buf_get_clients((bufnr or 0))), "name", "None")
end
_2amodule_2a["lspstatus"] = lspstatus
local function lsp_buf_get_active_clients(bufnr)
  local tbl_12_auto = {}
  for _0, client in ipairs(vim.lsp.get_active_clients()) do
    local _12_
    do
      local buffers = vim.lsp.get_buffers_by_client_id(client.id)
      if vim.tbl_contains(buffers, (bufnr or nvim.get_current_buf())) then
        _12_ = client
      else
      _12_ = nil
      end
    end
    tbl_12_auto[(#tbl_12_auto + 1)] = _12_
  end
  return tbl_12_auto
end
_2amodule_2a["lsp-buf-get-active-clients"] = lsp_buf_get_active_clients
local function lsp_buf_get_active_client(bufnr)
  return a.first(lsp_buf_get_active_clients(bufnr))
end
_2amodule_2a["lsp-buf-get-active-client"] = lsp_buf_get_active_client
local lsp_buf_get_active_client0 = lsp_buf_get_active_client
_2amodule_2a["lsp_buf_get_active_client"] = lsp_buf_get_active_client0
local function stop_lsp()
  for _0, client in ipairs(vim.lsp.get_active_clients()) do
    local buffers = vim.lsp.get_buffers_by_client_id(client.id)
    if vim.tbl_contains(buffers, nvim.get_current_buf()) then
      for _1, buf in ipairs(buffers) do
        vim.lsp.diagnostic.clear(buf, client.id)
      end
      vim.lsp.stop_client(client.id)
    end
  end
  return nil
end
_2amodule_2a["stop_lsp"] = stop_lsp
nvu["fn-bridge"]("LspStatus", "dotfiles.util", "lspstatus")
nvu["fn-bridge"]("StopLsp", "dotfiles.util", "stop_lsp")
if a["nil?"](a.get(vim.api.nvim_get_commands({builtin = false}), "StopLsp")) then
  return nvim.ex.command_("StopLsp call StopLsp()")
end