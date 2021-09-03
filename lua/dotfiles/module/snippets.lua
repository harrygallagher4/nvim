local _2afile_2a = "fnl/dotfiles/module/snippets.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.snippets"
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
    return {require("aniseed.core"), require("luasnip"), require("aniseed.nvim"), require("aniseed.string"), require("dotfiles.util")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true, ["dotfiles.snippets.macros"] = true}, require = {a = "aniseed.core", ls = "luasnip", nvim = "aniseed.nvim", str = "aniseed.string", util = "dotfiles.util"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local ls = _local_4_[2]
local nvim = _local_4_[3]
local str = _local_4_[4]
local util = _local_4_[5]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.snippets"
do local _ = ({nil, _1_, nil, {{nil, nil}, nil, nil, nil}})[2] end
local s
do
  local v_23_auto
  do
    local v_25_auto = ls.s
    _1_["s"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["s"] = v_23_auto
  s = v_23_auto
end
local t
do
  local v_23_auto
  do
    local v_25_auto = ls.t
    _1_["t"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["t"] = v_23_auto
  t = v_23_auto
end
local i
do
  local v_23_auto
  do
    local v_25_auto = ls.i
    _1_["i"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["i"] = v_23_auto
  i = v_23_auto
end
local snipf
do
  local v_23_auto
  do
    local v_25_auto = ls.f
    _1_["snipf"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["snipf"] = v_23_auto
  snipf = v_23_auto
end
local c
do
  local v_23_auto
  do
    local v_25_auto = ls.c
    _1_["c"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["c"] = v_23_auto
  c = v_23_auto
end
local d
do
  local v_23_auto
  do
    local v_25_auto = ls.d
    _1_["d"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["d"] = v_23_auto
  d = v_23_auto
end
local sn
do
  local v_23_auto
  do
    local v_25_auto = ls.sn
    _1_["sn"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["sn"] = v_23_auto
  sn = v_23_auto
end
local vsc
do
  local v_23_auto
  do
    local v_25_auto = a["get-in"](ls, {"parser", "parse_snippet"})
    do end (_1_)["vsc"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["vsc"] = v_23_auto
  vsc = v_23_auto
end
local current_module_name
do
  local v_23_auto
  local function current_module_name0()
    local file = vim.fn.expand("%:p:~:r")
    local start, _end = string.find(file, "/fnl/")
    return table.concat(str.split(string.sub(string.sub(file, _end), 2), "/"), ".")
  end
  v_23_auto = current_module_name0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["current-module-name"] = v_23_auto
  current_module_name = v_23_auto
end
local module_name_snip
do
  local v_23_auto
  local function module_name_snip0()
    return sn(nil, {i(1, {current_module_name()})})
  end
  v_23_auto = module_name_snip0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["module-name-snip"] = v_23_auto
  module_name_snip = v_23_auto
end
local snips
do
  local v_23_auto
  local function _8_(args)
    return {(a["get-in"](args, {1, "captures", 1}) .. " = ")}
  end
  v_23_auto = {all = {vsc({trig = "sniptest"}, "snippet ${0:sniptest} inserted!")}, fennel = {s({dscr = "Aniseed module definition", name = "Module (dynamic)", trig = "module"}, {t({"(module "}), d(1, module_name_snip, {}), t({"", "  {require {"}), i(2, {"a aniseed.core"}), t({"}"}), t({"", "   require-macros ["}), i(3, {"dotfiles.macros"}), t({"]})", ""}), i(0)})}, nix = {s({dscr = "Nix attribute name", name = "Attribute", regTrig = true, trig = "=([%w%.]+)", wordTrig = true}, {snipf(_8_, {}), i(0), t({";"})})}, rust = {vsc({trig = "fn"}, "/// $1\nfn $2($3) ${4:-> $5 }\\{\n\9$0\n\\}")}}
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["snips"] = v_23_auto
  snips = v_23_auto
end
return a.assoc(ls, "snippets", snips)