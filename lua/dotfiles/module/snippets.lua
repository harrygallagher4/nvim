local _2afile_2a = "fnl/dotfiles/module/snippets.fnl"
local _2amodule_name_2a = "dotfiles.module.snippets"
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
local a, ls, nvim, str, util, _, _0 = require("aniseed.core"), require("luasnip"), require("aniseed.nvim"), require("aniseed.string"), require("dotfiles.util"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["ls"] = ls
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["util"] = util
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
local s = ls.s
_2amodule_2a["s"] = s
local t = ls.t
_2amodule_2a["t"] = t
local i = ls.i
_2amodule_2a["i"] = i
local F = ls.f
_2amodule_2a["F"] = F
local c = ls.c
_2amodule_2a["c"] = c
local d = ls.d
_2amodule_2a["d"] = d
local sn = ls.sn
_2amodule_2a["sn"] = sn
local vsc = a["get-in"](ls, {"parser", "parse_snippet"})
do end (_2amodule_2a)["vsc"] = vsc
local function current_module_name()
  local file = vim.fn.expand("%:p:~:r")
  local start, _end = string.find(file, "/fnl/")
  return table.concat(str.split(string.sub(string.sub(file, _end), 2), "/"), ".")
end
_2amodule_locals_2a["current-module-name"] = current_module_name
local function module_name_snip()
  return sn(nil, {i(1, {current_module_name()})})
end
_2amodule_locals_2a["module-name-snip"] = module_name_snip
local snips
local function _1_(args)
  return {(a["get-in"](args, {1, "captures", 1}) .. " = ")}
end
snips = {all = {vsc({trig = "sniptest"}, "snippet ${0:sniptest} inserted!")}, nix = {s({name = "Attribute", dscr = "Nix attribute name", trig = "=([%w%.]+)", regTrig = true, wordTrig = true}, {F(_1_, {}), i(0), t({";"})})}, rust = {vsc({trig = "fn"}, "/// $1\nfn $2($3) ${4:-> $5 }\\{\n\9$0\n\\}")}, fennel = {s({name = "Module (dynamic)", dscr = "Aniseed module definition", trig = "module"}, {t({"(module "}), d(1, module_name_snip, {}), t({"", "  {require {"}), i(2, {"a aniseed.core"}), t({"}"}), t({"", "   require-macros ["}), i(3, {"dotfiles.macros"}), t({"]})", ""}), i(0)})}}
_2amodule_locals_2a["snips"] = snips
return a.assoc(ls, "snippets", snips)