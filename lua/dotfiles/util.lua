local _2afile_2a = "fnl/dotfiles/util.fnl"
local _1_
do
  local name_4_auto = "dotfiles.util"
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
    return {require("aniseed.core"), require("aniseed.env"), require("plenary.iterators"), require("aniseed.nvim"), require("aniseed.nvim.util"), require("plenary.reload")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", env = "aniseed.env", it = "plenary.iterators", nvim = "aniseed.nvim", nvu = "aniseed.nvim.util", preload = "plenary.reload"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local env = _local_4_[2]
local it = _local_4_[3]
local nvim = _local_4_[4]
local nvu = _local_4_[5]
local preload = _local_4_[6]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.util"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local config_path
do
  local v_23_auto
  do
    local v_25_auto = nvim.fn.stdpath("config")
    do end (_1_)["config-path"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["config-path"] = v_23_auto
  config_path = v_23_auto
end
local unpack
do
  local v_23_auto
  do
    local v_25_auto = (rawget(_G, "unpack") or table.unpack)
    do end (_1_)["unpack"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["unpack"] = v_23_auto
  unpack = v_23_auto
end
local slice
do
  local v_23_auto
  do
    local v_25_auto
    local function slice0(t, s, e)
      return {unpack(t, s, e)}
    end
    v_25_auto = slice0
    _1_["slice"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["slice"] = v_23_auto
  slice = v_23_auto
end
local zipmap
do
  local v_23_auto
  do
    local v_25_auto
    local function zipmap0(...)
      return it.zip(...):tomap()
    end
    v_25_auto = zipmap0
    _1_["zipmap"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["zipmap"] = v_23_auto
  zipmap = v_23_auto
end
local even_key
do
  local v_23_auto
  do
    local v_25_auto
    local function even_key0(_8_)
      local _arg_9_ = _8_
      local x = _arg_9_[1]
      local y = _arg_9_[2]
      if (0 == (x % 2)) then
        return y
      end
    end
    v_25_auto = even_key0
    _1_["even-key"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["even-key"] = v_23_auto
  even_key = v_23_auto
end
local odd_key
do
  local v_23_auto
  do
    local v_25_auto
    local function odd_key0(_11_)
      local _arg_12_ = _11_
      local x = _arg_12_[1]
      local y = _arg_12_[2]
      if not (0 == (x % 2)) then
        return y
      end
    end
    v_25_auto = odd_key0
    _1_["odd-key"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["odd-key"] = v_23_auto
  odd_key = v_23_auto
end
local split_seq
do
  local v_23_auto
  do
    local v_25_auto
    local function split_seq0(t)
      local odd = a["map-indexed"](odd_key, t)
      local even = a["map-indexed"](even_key, t)
      local function _14_()
        if (#odd == #even) then
          return {odd, even}
        else
          return {a.butlast(odd), even}
        end
      end
      return unpack(_14_())
    end
    v_25_auto = split_seq0
    _1_["split-seq"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["split-seq"] = v_23_auto
  split_seq = v_23_auto
end
local expand
do
  local v_23_auto
  do
    local v_25_auto
    local function expand0(path)
      return nvim.fn.expand(path)
    end
    v_25_auto = expand0
    _1_["expand"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["expand"] = v_23_auto
  expand = v_23_auto
end
local glob
do
  local v_23_auto
  do
    local v_25_auto
    local function glob0(path)
      return nvim.fn.glob(path, true, true, true)
    end
    v_25_auto = glob0
    _1_["glob"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["glob"] = v_23_auto
  glob = v_23_auto
end
local exists_3f
do
  local v_23_auto
  do
    local v_25_auto
    local function exists_3f0(path)
      return (nvim.fn.filereadable(path) == 1)
    end
    v_25_auto = exists_3f0
    _1_["exists?"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["exists?"] = v_23_auto
  exists_3f = v_23_auto
end
local lua_file
do
  local v_23_auto
  do
    local v_25_auto
    local function lua_file0(path)
      return nvim.ex.luafile(path)
    end
    v_25_auto = lua_file0
    _1_["lua-file"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lua-file"] = v_23_auto
  lua_file = v_23_auto
end
local oset_arg
do
  local v_23_auto
  local function oset_arg0(x, y, z)
    if z then
      return (x .. y .. z)
    elseif y then
      return (x .. "=" .. y)
    else
      return x
    end
  end
  v_23_auto = oset_arg0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["oset-arg"] = v_23_auto
  oset_arg = v_23_auto
end
local oset_21
do
  local v_23_auto
  do
    local v_25_auto
    local function oset_210(x, y, z)
      return nvim.ex.set(oset_arg(x, y, z))
    end
    v_25_auto = oset_210
    _1_["oset!"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["oset!"] = v_23_auto
  oset_21 = v_23_auto
end
local memoize
do
  local v_23_auto
  do
    local v_25_auto
    local function memoize0(f)
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
    v_25_auto = memoize0
    _1_["memoize"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["memoize"] = v_23_auto
  memoize = v_23_auto
end
local print_inspect
do
  local v_23_auto
  do
    local v_25_auto
    local function print_inspect0(o)
      print(vim.inspect(o))
      return o
    end
    v_25_auto = print_inspect0
    _1_["print_inspect"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["print_inspect"] = v_23_auto
  print_inspect = v_23_auto
end
_G["pr"] = print_inspect
if not a["nil?"](preload.reload_module) then
  local function _17_(m)
    preload.reload_module(m)
    return require(m)
  end
  _G["reload"] = _17_
end
local lspstatus
do
  local v_23_auto
  do
    local v_25_auto
    local function lspstatus0(bufnr)
      return a.get(a.first(vim.lsp.buf_get_clients((bufnr or 0))), "name", "None")
    end
    v_25_auto = lspstatus0
    _1_["lspstatus"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lspstatus"] = v_23_auto
  lspstatus = v_23_auto
end
local lsp_buf_get_active_clients
do
  local v_23_auto
  do
    local v_25_auto
    local function lsp_buf_get_active_clients0(bufnr)
      local tbl_12_auto = {}
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        local _19_
        do
          local buffers = vim.lsp.get_buffers_by_client_id(client.id)
          if vim.tbl_contains(buffers, (bufnr or nvim.get_current_buf())) then
            _19_ = client
          else
          _19_ = nil
          end
        end
        tbl_12_auto[(#tbl_12_auto + 1)] = _19_
      end
      return tbl_12_auto
    end
    v_25_auto = lsp_buf_get_active_clients0
    _1_["lsp-buf-get-active-clients"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lsp-buf-get-active-clients"] = v_23_auto
  lsp_buf_get_active_clients = v_23_auto
end
local lsp_buf_get_active_client
do
  local v_23_auto
  do
    local v_25_auto
    local function lsp_buf_get_active_client0(bufnr)
      return a.first(lsp_buf_get_active_clients(bufnr))
    end
    v_25_auto = lsp_buf_get_active_client0
    _1_["lsp-buf-get-active-client"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lsp-buf-get-active-client"] = v_23_auto
  lsp_buf_get_active_client = v_23_auto
end
local lsp_buf_get_active_client0
do
  local v_23_auto
  do
    local v_25_auto = lsp_buf_get_active_client
    _1_["lsp_buf_get_active_client"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lsp_buf_get_active_client"] = v_23_auto
  lsp_buf_get_active_client0 = v_23_auto
end
local stop_lsp
do
  local v_23_auto
  do
    local v_25_auto
    local function stop_lsp0()
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        local buffers = vim.lsp.get_buffers_by_client_id(client.id)
        if vim.tbl_contains(buffers, nvim.get_current_buf()) then
          for _0, buf in ipairs(buffers) do
            vim.lsp.diagnostic.clear(buf, client.id)
          end
          vim.lsp.stop_client(client.id)
        end
      end
      return nil
    end
    v_25_auto = stop_lsp0
    _1_["stop_lsp"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["stop_lsp"] = v_23_auto
  stop_lsp = v_23_auto
end
nvu["fn-bridge"]("LspStatus", "dotfiles.util", "lspstatus")
nvu["fn-bridge"]("StopLsp", "dotfiles.util", "stop_lsp")
if a["nil?"](a.get(vim.api.nvim_get_commands({builtin = false}), "StopLsp")) then
  return nvim.ex.command_("StopLsp call StopLsp()")
end