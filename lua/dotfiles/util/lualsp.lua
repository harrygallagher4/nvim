local _2afile_2a = "fnl/dotfiles/util/lualsp.fnl"
local _1_
do
  local name_4_auto = "dotfiles.util.lualsp"
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
    return {require("aniseed.core"), require("lua-dev"), require("aniseed.nvim")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {require = {a = "aniseed.core", luadev = "lua-dev", nvim = "aniseed.nvim"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local luadev = _local_4_[2]
local nvim = _local_4_[3]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.util.lualsp"
do local _ = ({nil, _1_, nil, {{}, nil, nil, nil}})[2] end
local sumneko_root
do
  local v_23_auto
  do
    local v_25_auto = (nvim.fn.stdpath("cache") .. "/lsp/lua/")
    do end (_1_)["sumneko-root"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["sumneko-root"] = v_23_auto
  sumneko_root = v_23_auto
end
local p
do
  local v_23_auto
  local function p0(...)
    return (sumneko_root .. ...)
  end
  v_23_auto = p0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["p"] = v_23_auto
  p = v_23_auto
end
local bin
do
  local v_23_auto
  do
    local v_25_auto = p("bin/macOS/lua-language-server")
    do end (_1_)["bin"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["bin"] = v_23_auto
  bin = v_23_auto
end
local cmd
do
  local v_23_auto
  do
    local v_25_auto = {bin, "-E", p("main.lua")}
    _1_["cmd"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["cmd"] = v_23_auto
  cmd = v_23_auto
end
local ldconfig
do
  local v_23_auto = {cmd = cmd}
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["ldconfig"] = v_23_auto
  ldconfig = v_23_auto
end
local setup
do
  local v_23_auto
  do
    local v_25_auto
    local function setup0(...)
      return luadev.setup({library = {plugins = true, types = true, vimruntime = true}, lspconfig = a.merge(ldconfig, ...)})
    end
    v_25_auto = setup0
    _1_["setup"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["setup"] = v_23_auto
  setup = v_23_auto
end
return nil