local _2afile_2a = "fnl/harryg/colorutilsfnl.fnl"
local _1_
do
  local name_4_auto = "harryg.colorutilsfnl"
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
    return {require("aniseed.core"), require("hsluv"), require("nvim-web-devicons"), require("lush"), require("aniseed.nvim"), require("aniseed.string"), require("harryg.colorutils")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", hsluv = "hsluv", icons = "nvim-web-devicons", lush = "lush", nvim = "aniseed.nvim", str = "aniseed.string", u = "harryg.colorutils"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local hsluv = _local_4_[2]
local icons = _local_4_[3]
local lush = _local_4_[4]
local nvim = _local_4_[5]
local str = _local_4_[6]
local u = _local_4_[7]
local _2amodule_2a = _1_
local _2amodule_name_2a = "harryg.colorutilsfnl"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
do
  local a_6_auto = require("aniseed.core")
  local s_7_auto = require("aniseed.string")
  local v_8_auto = require("aniseed.nvim")
  if ((a_6_auto.last(s_7_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_6_auto.last(s_7_auto.split(v_8_auto.buf_get_name(0), "/"))) then
    local function _8_(...)
      local icons0 = (require("nvim-web-devicons")).get_icons()
      local cmap = {}
      local function _11_(_9_)
        local _arg_10_ = _9_
        local k = _arg_10_[1]
        local v = _arg_10_[2]
        cmap[string.lower(string.gsub(k, "^%.", ""))] = string.sub(v.color, 2)
        return nil
      end
      a["map-indexed"](_11_, icons0)
      return cmap
    end
    _8_(...)
  end
end
do
  local a_6_auto = require("aniseed.core")
  local s_7_auto = require("aniseed.string")
  local v_8_auto = require("aniseed.nvim")
  if ((a_6_auto.last(s_7_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_6_auto.last(s_7_auto.split(v_8_auto.buf_get_name(0), "/"))) then
    local function _15_(_13_)
      local _arg_14_ = _13_
      local k = _arg_14_[1]
      local v = _arg_14_[2]
      if a["nil?"](v.hex) then
        return a.map(tostring, v)
      else
        return tostring(v)
      end
    end
    a.map(tostring, a["get-in"](require("melange.colors"), {"Melange", "lush", "g"}))
    a["map-indexed"](_15_, a["get-in"](require("melange.colors"), {"Melange", "lush"}))
  end
end
local deg
do
  local v_23_auto = math.deg
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["deg"] = v_23_auto
  deg = v_23_auto
end
local rad
do
  local v_23_auto = math.rad
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["rad"] = v_23_auto
  rad = v_23_auto
end
local hex__3ehsluv
do
  local v_23_auto = hsluv.hex_to_hsluv
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hex->hsluv"] = v_23_auto
  hex__3ehsluv = v_23_auto
end
local hsluv__3ehex
do
  local v_23_auto = hsluv.hsluv_to_hex
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hsluv->hex"] = v_23_auto
  hsluv__3ehex = v_23_auto
end
local lush__3ehsluv
do
  local v_23_auto
  local function lush__3ehsluv0(c)
    return hex__3ehsluv(c.hex)
  end
  v_23_auto = lush__3ehsluv0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lush->hsluv"] = v_23_auto
  lush__3ehsluv = v_23_auto
end
local hsluv__3elush
do
  local v_23_auto
  local function hsluv__3elush0(c)
    return lush.hsl(hsluv__3ehex(c))
  end
  v_23_auto = hsluv__3elush0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hsluv->lush"] = v_23_auto
  hsluv__3elush = v_23_auto
end
local transform_h
do
  local v_23_auto
  local function transform_h0(c, f)
    return {f(c[1]), c[2], c[3]}
  end
  v_23_auto = transform_h0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["transform-h"] = v_23_auto
  transform_h = v_23_auto
end
local transform_s
do
  local v_23_auto
  local function transform_s0(c, f)
    return {c[1], f(c[2]), c[3]}
  end
  v_23_auto = transform_s0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["transform-s"] = v_23_auto
  transform_s = v_23_auto
end
local transform_l
do
  local v_23_auto
  local function transform_l0(c, f)
    return {c[1], c[2], f(c[3])}
  end
  v_23_auto = transform_l0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["transform-l"] = v_23_auto
  transform_l = v_23_auto
end
local linear_tween
do
  local v_23_auto
  local function linear_tween0(start, stop)
    local function _18_(i)
      return (start + (i * (stop - start)))
    end
    return _18_
  end
  v_23_auto = linear_tween0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["linear-tween"] = v_23_auto
  linear_tween = v_23_auto
end
local radial_tween
do
  local v_23_auto
  local function radial_tween0(x, y)
    local start = rad(x)
    local stop = rad(y)
    local delta = math.atan2(math.sin((stop - start)), math.cos((stop - start)))
    local function _19_(i)
      return ((360 + deg((start + (delta * i)))) % 360)
    end
    return _19_
  end
  v_23_auto = radial_tween0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["radial-tween"] = v_23_auto
  radial_tween = v_23_auto
end
local blend_hsluv
do
  local v_23_auto
  do
    local v_25_auto
    local function blend_hsluv0(start, stop, ratio)
      local ratio0 = (ratio or 0.5)
      local h = radial_tween(start[1], stop[1])
      local s = linear_tween(start[2], stop[2])
      local l = linear_tween(start[3], stop[3])
      return {h(ratio0), s(ratio0), l(ratio0)}
    end
    v_25_auto = blend_hsluv0
    _1_["blend-hsluv"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["blend-hsluv"] = v_23_auto
  blend_hsluv = v_23_auto
end
local blend_old
do
  local v_23_auto
  local function blend_old0(start, stop, ratio)
    local c1 = hsluv.hex_to_hsluv(start.hex)
    local c2 = hsluv.hex_to_hsluv(stop.hex)
    return lush.hsl(hsluv.hsluv_to_hex(blend_hsluv(c1, c2, ratio)))
  end
  v_23_auto = blend_old0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["blend-old"] = v_23_auto
  blend_old = v_23_auto
end
local blend_lush
do
  local v_23_auto
  do
    local v_25_auto
    local function blend_lush0(c1, c2, r)
      return lush.hsl(hsluv.hsluv_to_hex(blend_hsluv(hsluv.hex_to_hsluv(c1.hex), hsluv.hex_to_hsluv(c2.hex), r)))
    end
    v_25_auto = blend_lush0
    _1_["blend-lush"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["blend-lush"] = v_23_auto
  blend_lush = v_23_auto
end
local blend_hex
do
  local v_23_auto
  do
    local v_25_auto
    local function blend_hex0(c1, c2, r)
      return hsluv.hsluv_to_hex(blend_hsluv(hsluv.hex_to_hsluv(c1), hsluv.hex_to_hsluv(c2), r))
    end
    v_25_auto = blend_hex0
    _1_["blend-hex"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["blend-hex"] = v_23_auto
  blend_hex = v_23_auto
end
local blend
do
  local v_23_auto
  do
    local v_25_auto = blend_lush
    _1_["blend"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["blend"] = v_23_auto
  blend = v_23_auto
end
local lighten
do
  local v_23_auto
  local function lighten0(c, n)
    local l = linear_tween(c[3], 100)
    return {c[1], c[2], l(n)}
  end
  v_23_auto = lighten0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lighten"] = v_23_auto
  lighten = v_23_auto
end
local darken
do
  local v_23_auto
  local function darken0(c, n)
    local l = linear_tween(c[3], 0)
    return {c[1], c[2], l(n)}
  end
  v_23_auto = darken0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["darken"] = v_23_auto
  darken = v_23_auto
end
local saturate
do
  local v_23_auto
  local function saturate0(c, n)
    local s = linear_tween(c[2], 100)
    return {c[1], s(n), c[3]}
  end
  v_23_auto = saturate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["saturate"] = v_23_auto
  saturate = v_23_auto
end
local desaturate
do
  local v_23_auto
  local function desaturate0(c, n)
    local s = linear_tween(c[2], 0)
    return {c[1], s(n), c[3]}
  end
  v_23_auto = desaturate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["desaturate"] = v_23_auto
  desaturate = v_23_auto
end
local rotate
do
  local v_23_auto
  local function rotate0(c, n)
    return {((n + c[1]) % 360), c[2], c[3]}
  end
  v_23_auto = rotate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["rotate"] = v_23_auto
  rotate = v_23_auto
end
local lush_lighten
do
  local v_23_auto
  do
    local v_25_auto
    local function lush_lighten0(c, n)
      return hsluv__3elush(lighten(lush__3ehsluv(c), n))
    end
    v_25_auto = lush_lighten0
    _1_["lush_lighten"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lush_lighten"] = v_23_auto
  lush_lighten = v_23_auto
end
local lush_darken
do
  local v_23_auto
  do
    local v_25_auto
    local function lush_darken0(c, n)
      return hsluv__3elush(darken(lush__3ehsluv(c), n))
    end
    v_25_auto = lush_darken0
    _1_["lush_darken"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lush_darken"] = v_23_auto
  lush_darken = v_23_auto
end
local lush_saturate
do
  local v_23_auto
  do
    local v_25_auto
    local function lush_saturate0(c, n)
      return hsluv__3elush(saturate(lush__3ehsluv(c), n))
    end
    v_25_auto = lush_saturate0
    _1_["lush_saturate"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lush_saturate"] = v_23_auto
  lush_saturate = v_23_auto
end
local lush_desaturate
do
  local v_23_auto
  do
    local v_25_auto
    local function lush_desaturate0(c, n)
      return hsluv__3elush(desaturate(lush__3ehsluv(c), n))
    end
    v_25_auto = lush_desaturate0
    _1_["lush_desaturate"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lush_desaturate"] = v_23_auto
  lush_desaturate = v_23_auto
end
local lush_rotate
do
  local v_23_auto
  do
    local v_25_auto
    local function lush_rotate0(c, n)
      return hsluv__3elush(rotate(lush__3ehsluv(c), n))
    end
    v_25_auto = lush_rotate0
    _1_["lush_rotate"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lush_rotate"] = v_23_auto
  lush_rotate = v_23_auto
end
local gradient
do
  local v_23_auto
  local function gradient0(c1, c2)
    local ls = {}
    for i = 0, 1.01, 0.02 do
      ls = a.concat(ls, {i})
    end
    local function _20_(_241)
      return blend_hex(c1, c2, _241)
    end
    return a.map(_20_, ls)
  end
  v_23_auto = gradient0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["gradient"] = v_23_auto
  gradient = v_23_auto
end
local gradient_n
do
  local v_23_auto
  local function gradient_n0(c1, c2, n)
    local ls = {}
    do
      local step = (1 / (n + 1))
      for i = 1, n, 1 do
        ls = a.concat(ls, {(i * step)})
      end
    end
    local function _21_(_241)
      return blend_hex(c1, c2, _241)
    end
    return a.concat({c1}, a.map(_21_, ls), {c2})
  end
  v_23_auto = gradient_n0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["gradient-n"] = v_23_auto
  gradient_n = v_23_auto
end
local palette
do
  local v_23_auto
  local function palette0(c)
    return ((require("melange.colors")).Melange.lush[c]).hex
  end
  v_23_auto = palette0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["palette"] = v_23_auto
  palette = v_23_auto
end
local palette_lush
do
  local v_23_auto
  local function palette_lush0(c)
    return (require("melange.colors")).Melange.lush[c]
  end
  v_23_auto = palette_lush0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["palette-lush"] = v_23_auto
  palette_lush = v_23_auto
end
do
  local a_6_auto = require("aniseed.core")
  local s_7_auto = require("aniseed.string")
  local v_8_auto = require("aniseed.nvim")
  if ((a_6_auto.last(s_7_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_6_auto.last(s_7_auto.split(v_8_auto.buf_get_name(0), "/"))) then
    tostring(hsluv__3elush(darken(lush__3ehsluv(palette_lush("blue")), 0.4)))
    tostring(hsluv__3elush(darken(saturate(rotate(lush__3ehsluv(palette_lush("yellow")), 120), 0.075), 0.25)))
    tostring(lush_lighten(palette_lush("blue"), 0.1))
    tostring(lush_darken(palette_lush("blue"), 0.4))
    tostring(lush_saturate(palette_lush("red"), 0.25))
    tostring(lush_desaturate(palette_lush("red"), 0.25))
    tostring(lush_rotate(palette_lush("red"), 180))
    do local _ = (palette("red") .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 180))) end
    do local _ = (hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 240)) .. " " .. palette("red") .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 120))) end
    do local _ = (hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 216)) .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 288)) .. " " .. palette("red") .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 72)) .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 144))) end
    do local _ = (palette("red") .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 90)) .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 180)) .. " " .. hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 270))) end
    hsluv__3ehex(rotate(hex__3ehsluv(palette("red")), 180))
    hsluv__3ehex(lighten(hex__3ehsluv(palette("red")), 0.25))
    hsluv__3ehex(darken(hex__3ehsluv(palette("red")), 0.25))
    hsluv__3ehex(saturate(hex__3ehsluv(palette("red")), 0.25))
    hsluv__3ehex(desaturate(hex__3ehsluv(palette("red")), 0.25))
  end
end
local a_6_auto = require("aniseed.core")
local s_7_auto = require("aniseed.string")
local v_8_auto = require("aniseed.nvim")
if ((a_6_auto.last(s_7_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_6_auto.last(s_7_auto.split(v_8_auto.buf_get_name(0), "/"))) then
  local function _23_(_241)
    return (_241 * 2)
  end
  local function _24_(_241)
    return (_241 * 1.1)
  end
  local function _25_(_241)
    return (_241 * 1.1)
  end
  return transform_h(hex__3ehsluv(palette("red")), _23_), transform_s(hex__3ehsluv(palette("red")), _24_), transform_l(hex__3ehsluv(palette("red")), _25_), palette("red"), gradient_n(palette("green"), "#2a2621", 36), gradient("#d65c71", "#2a2621"), tostring(blend(lush.hsl(palette("red")), lush.hsl(palette("green")), 0.5)), (blend(lush.hsl("#ff7e7e"), lush.hsl("#4a4a4a"))).hex, (u.blend(lush.hsl("#ff7e7e"), lush.hsl("#4a4a4a"))).hex, blend_hex("#ff7e7e", "#4a4a4a"), u.blend_hex("#ff7e7e", "#4a4a4a"), hsluv.hsluv_to_hex(blend_hsluv(hsluv.hex_to_hsluv("#ff7e7e"), hsluv.hex_to_hsluv("#4a4a4a"))), hsluv.hsluv_to_hex(u.blend_hsluv(hsluv.hex_to_hsluv("#ff7e7e"), hsluv.hex_to_hsluv("#4a4a4a")))
end