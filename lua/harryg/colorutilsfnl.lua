local _2afile_2a = "fnl/harryg/colorutilsfnl.fnl"
local _2amodule_name_2a = "harryg.colorutilsfnl"
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
local a, hsluv, icons, lush, nvim, str, u, _ = require("aniseed.core"), require("hsluv"), require("nvim-web-devicons"), require("lush"), require("aniseed.nvim"), require("aniseed.string"), require("harryg.colorutils"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["hsluv"] = hsluv
_2amodule_locals_2a["icons"] = icons
_2amodule_locals_2a["lush"] = lush
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["u"] = u
_2amodule_locals_2a["_"] = _
do
  local a_2_auto = require("aniseed.core")
  local s_3_auto = require("aniseed.string")
  local v_4_auto = require("aniseed.nvim")
  if ((a_2_auto.last(s_3_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_2_auto.last(s_3_auto.split(v_4_auto.buf_get_name(0), "/"))) then
    local function _1_(...)
      local icons0 = (require("nvim-web-devicons")).get_icons()
      local cmap = {}
      local function _4_(_2_)
        local _arg_3_ = _2_
        local k = _arg_3_[1]
        local v = _arg_3_[2]
        cmap[string.lower(string.gsub(k, "^%.", ""))] = string.sub(v.color, 2)
        return nil
      end
      a["map-indexed"](_4_, icons0)
      return cmap
    end
    _1_(...)
  else
  end
end
do
  local a_2_auto = require("aniseed.core")
  local s_3_auto = require("aniseed.string")
  local v_4_auto = require("aniseed.nvim")
  if ((a_2_auto.last(s_3_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_2_auto.last(s_3_auto.split(v_4_auto.buf_get_name(0), "/"))) then
    local function _8_(_6_)
      local _arg_7_ = _6_
      local k = _arg_7_[1]
      local v = _arg_7_[2]
      if a["nil?"](v.hex) then
        return a.map(tostring, v)
      else
        return tostring(v)
      end
    end
    a.map(tostring, a["get-in"](require("melange.colors"), {"Melange", "lush", "g"}))
    a["map-indexed"](_8_, a["get-in"](require("melange.colors"), {"Melange", "lush"}))
  else
  end
end
local deg = math.deg
_2amodule_locals_2a["deg"] = deg
local rad = math.rad
_2amodule_locals_2a["rad"] = rad
local hex__3ehsluv = hsluv.hex_to_hsluv
_2amodule_locals_2a["hex->hsluv"] = hex__3ehsluv
local hsluv__3ehex = hsluv.hsluv_to_hex
_2amodule_locals_2a["hsluv->hex"] = hsluv__3ehex
local function lush__3ehsluv(c)
  return hex__3ehsluv(c.hex)
end
_2amodule_locals_2a["lush->hsluv"] = lush__3ehsluv
local function hsluv__3elush(c)
  return lush.hsl(hsluv__3ehex(c))
end
_2amodule_locals_2a["hsluv->lush"] = hsluv__3elush
local function transform_h(c, f)
  return {f(c[1]), c[2], c[3]}
end
_2amodule_locals_2a["transform-h"] = transform_h
local function transform_s(c, f)
  return {c[1], f(c[2]), c[3]}
end
_2amodule_locals_2a["transform-s"] = transform_s
local function transform_l(c, f)
  return {c[1], c[2], f(c[3])}
end
_2amodule_locals_2a["transform-l"] = transform_l
local function linear_tween(start, stop)
  local function _11_(i)
    return (start + (i * (stop - start)))
  end
  return _11_
end
_2amodule_locals_2a["linear-tween"] = linear_tween
local function radial_tween(x, y)
  local start = rad(x)
  local stop = rad(y)
  local delta = math.atan2(math.sin((stop - start)), math.cos((stop - start)))
  local function _12_(i)
    return ((360 + deg((start + (delta * i)))) % 360)
  end
  return _12_
end
_2amodule_locals_2a["radial-tween"] = radial_tween
local function blend_hsluv(start, stop, ratio)
  local ratio0 = (ratio or 0.5)
  local h = radial_tween(start[1], stop[1])
  local s = linear_tween(start[2], stop[2])
  local l = linear_tween(start[3], stop[3])
  return {h(ratio0), s(ratio0), l(ratio0)}
end
_2amodule_2a["blend-hsluv"] = blend_hsluv
local function blend_old(start, stop, ratio)
  local c1 = hsluv.hex_to_hsluv(start.hex)
  local c2 = hsluv.hex_to_hsluv(stop.hex)
  return lush.hsl(hsluv.hsluv_to_hex(blend_hsluv(c1, c2, ratio)))
end
_2amodule_locals_2a["blend-old"] = blend_old
local function blend_lush(c1, c2, r)
  return lush.hsl(hsluv.hsluv_to_hex(blend_hsluv(hsluv.hex_to_hsluv(c1.hex), hsluv.hex_to_hsluv(c2.hex), r)))
end
_2amodule_2a["blend-lush"] = blend_lush
local function blend_hex(c1, c2, r)
  return hsluv.hsluv_to_hex(blend_hsluv(hsluv.hex_to_hsluv(c1), hsluv.hex_to_hsluv(c2), r))
end
_2amodule_2a["blend-hex"] = blend_hex
local blend = blend_lush
_2amodule_2a["blend"] = blend
local function lighten(c, n)
  local l = linear_tween(c[3], 100)
  return {c[1], c[2], l(n)}
end
_2amodule_locals_2a["lighten"] = lighten
local function darken(c, n)
  local l = linear_tween(c[3], 0)
  return {c[1], c[2], l(n)}
end
_2amodule_locals_2a["darken"] = darken
local function saturate(c, n)
  local s = linear_tween(c[2], 100)
  return {c[1], s(n), c[3]}
end
_2amodule_locals_2a["saturate"] = saturate
local function desaturate(c, n)
  local s = linear_tween(c[2], 0)
  return {c[1], s(n), c[3]}
end
_2amodule_locals_2a["desaturate"] = desaturate
local function rotate(c, n)
  return {((n + c[1]) % 360), c[2], c[3]}
end
_2amodule_locals_2a["rotate"] = rotate
local function lush_lighten(c, n)
  return hsluv__3elush(lighten(lush__3ehsluv(c), n))
end
_2amodule_2a["lush_lighten"] = lush_lighten
local function lush_darken(c, n)
  return hsluv__3elush(darken(lush__3ehsluv(c), n))
end
_2amodule_2a["lush_darken"] = lush_darken
local function lush_saturate(c, n)
  return hsluv__3elush(saturate(lush__3ehsluv(c), n))
end
_2amodule_2a["lush_saturate"] = lush_saturate
local function lush_desaturate(c, n)
  return hsluv__3elush(desaturate(lush__3ehsluv(c), n))
end
_2amodule_2a["lush_desaturate"] = lush_desaturate
local function lush_rotate(c, n)
  return hsluv__3elush(rotate(lush__3ehsluv(c), n))
end
_2amodule_2a["lush_rotate"] = lush_rotate
local function gradient(c1, c2)
  local ls = {}
  for i = 0, 1.01, 0.02 do
    ls = a.concat(ls, {i})
  end
  local function _13_(_241)
    return blend_hex(c1, c2, _241)
  end
  return a.map(_13_, ls)
end
_2amodule_locals_2a["gradient"] = gradient
local function gradient_n(c1, c2, n)
  local ls = {}
  do
    local step = (1 / (n + 1))
    for i = 1, n, 1 do
      ls = a.concat(ls, {(i * step)})
    end
  end
  local function _14_(_241)
    return blend_hex(c1, c2, _241)
  end
  return a.concat({c1}, a.map(_14_, ls), {c2})
end
_2amodule_locals_2a["gradient-n"] = gradient_n
local function palette(c)
  return ((require("melange.colors")).Melange.lush[c]).hex
end
_2amodule_locals_2a["palette"] = palette
local function palette_lush(c)
  return (require("melange.colors")).Melange.lush[c]
end
_2amodule_locals_2a["palette-lush"] = palette_lush
do
  local a_2_auto = require("aniseed.core")
  local s_3_auto = require("aniseed.string")
  local v_4_auto = require("aniseed.nvim")
  if ((a_2_auto.last(s_3_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_2_auto.last(s_3_auto.split(v_4_auto.buf_get_name(0), "/"))) then
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
  else
  end
end
local a_2_auto = require("aniseed.core")
local s_3_auto = require("aniseed.string")
local v_4_auto = require("aniseed.nvim")
if ((a_2_auto.last(s_3_auto.split(_2amodule_name_2a, "%.")) .. ".fnl") == a_2_auto.last(s_3_auto.split(v_4_auto.buf_get_name(0), "/"))) then
  local function _16_(_241)
    return (_241 * 2)
  end
  local function _17_(_241)
    return (_241 * 1.1)
  end
  local function _18_(_241)
    return (_241 * 1.1)
  end
  return transform_h(hex__3ehsluv(palette("red")), _16_), transform_s(hex__3ehsluv(palette("red")), _17_), transform_l(hex__3ehsluv(palette("red")), _18_), palette("red"), gradient_n(palette("green"), "#2a2621", 36), gradient("#d65c71", "#2a2621"), tostring(blend(lush.hsl(palette("red")), lush.hsl(palette("green")), 0.5)), (blend(lush.hsl("#ff7e7e"), lush.hsl("#4a4a4a"))).hex, (u.blend(lush.hsl("#ff7e7e"), lush.hsl("#4a4a4a"))).hex, blend_hex("#ff7e7e", "#4a4a4a"), u.blend_hex("#ff7e7e", "#4a4a4a"), hsluv.hsluv_to_hex(blend_hsluv(hsluv.hex_to_hsluv("#ff7e7e"), hsluv.hex_to_hsluv("#4a4a4a"))), hsluv.hsluv_to_hex(u.blend_hsluv(hsluv.hex_to_hsluv("#ff7e7e"), hsluv.hex_to_hsluv("#4a4a4a")))
else
  return nil
end