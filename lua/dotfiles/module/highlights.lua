local _2afile_2a = "fnl/dotfiles/module/highlights.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.highlights"
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
    return {require("aniseed.core"), require("colorizer"), require("lush"), require("aniseed.nvim"), require("aniseed.string")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.highlight.macros"] = true, ["dotfiles.macros"] = true}, require = {a = "aniseed.core", colorizer = "colorizer", lush = "lush", nvim = "aniseed.nvim", str = "aniseed.string"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local colorizer = _local_4_[2]
local lush = _local_4_[3]
local nvim = _local_4_[4]
local str = _local_4_[5]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.highlights"
do local _ = ({nil, _1_, nil, {{nil, nil}, nil, nil, nil}})[2] end
colorizer.setup(nil, {mode = "both", names = false})
local hsl
do
  local v_23_auto = lush.hsl
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hsl"] = v_23_auto
  hsl = v_23_auto
end
local gruvbox
do
  local v_23_auto
  do
    local v_25_auto = {NONE = "NONE", aqua = "#8ec07c", bg0 = "#32302f", bg1 = "#3c3836", bg2 = "#504945", bg3 = "#665c54", bg4 = "#7c6f64", blue = "#83a598", bright_aqua = "#8ec07c", bright_blue = "#83a598", bright_green = "#b8bb26", bright_orange = "#fe8019", bright_purple = "#d3869b", bright_red = "#fb4934", bright_yellow = "#fabd2f", dark0 = "#282828", dark0_hard = "#1d2021", dark0_soft = "#32302f", dark1 = "#3c3836", dark2 = "#504945", dark3 = "#665c54", dark4 = "#7c6f64", faded_aqua = "#427b58", faded_blue = "#076678", faded_green = "#79740e", faded_orange = "#af3a03", faded_purple = "#8f3f71", faded_red = "#9d0006", faded_yellow = "#b57614", fg0 = "#fbf1c7", fg1 = "#ebdbb2", fg2 = "#d5c4a1", fg3 = "#bdae93", fg4 = "#a89984", gray = "#928374", green = "#b8bb26", light0 = "#fbf1c7", light0_hard = "#f9f5d7", light0_soft = "#f2e5bc", light1 = "#ebdbb2", light2 = "#d5c4a1", light3 = "#bdae93", light4 = "#a89984", neutral_aqua = "#689d6a", neutral_blue = "#458588", neutral_green = "#98971a", neutral_orange = "#d65d0e", neutral_purple = "#b16286", neutral_red = "#cc241d", neutral_yellow = "#d79921", orange = "#fe8019", purple = "#d3869b", red = "#fb4934", sl = "#32302e", yellow = "#fabd2f"}
    _1_["gruvbox"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["gruvbox"] = v_23_auto
  gruvbox = v_23_auto
end
local resolve_color
do
  local v_23_auto
  do
    local v_25_auto
    local function resolve_color0(color)
      return (string.match(color, "#%x%x%x%x%x%x") or a.get(gruvbox, color))
    end
    v_25_auto = resolve_color0
    _1_["resolve-color"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["resolve-color"] = v_23_auto
  resolve_color = v_23_auto
end
local lushcolor
do
  local v_23_auto
  do
    local v_25_auto
    local function lushcolor0(color)
      return hsl(resolve_color(color))
    end
    v_25_auto = lushcolor0
    _1_["lushcolor"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lushcolor"] = v_23_auto
  lushcolor = v_23_auto
end
local __
do
  local v_23_auto
  do
    local v_25_auto
    local function __0(...)
      return str.join(" ", {...})
    end
    v_25_auto = __0
    _1_["__"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["__"] = v_23_auto
  __ = v_23_auto
end
local notblank_3f
do
  local v_23_auto
  do
    local v_25_auto
    local function notblank_3f0(s)
      return not str["blank?"](s)
    end
    v_25_auto = notblank_3f0
    _1_["notblank?"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["notblank?"] = v_23_auto
  notblank_3f = v_23_auto
end
local fg
do
  local v_23_auto
  do
    local v_25_auto
    local function fg0(color)
      return str.join({"guifg=", resolve_color(color)})
    end
    v_25_auto = fg0
    _1_["fg"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["fg"] = v_23_auto
  fg = v_23_auto
end
local bg
do
  local v_23_auto
  do
    local v_25_auto
    local function bg0(color)
      return str.join({"guibg=", resolve_color(color)})
    end
    v_25_auto = bg0
    _1_["bg"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["bg"] = v_23_auto
  bg = v_23_auto
end
local gui
do
  local v_23_auto
  do
    local v_25_auto
    local function gui0(prop)
      return str.join({"gui=", prop})
    end
    v_25_auto = gui0
    _1_["gui"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["gui"] = v_23_auto
  gui = v_23_auto
end
local highlight
do
  local v_23_auto
  do
    local v_25_auto = nvim.ex.highlight
    _1_["highlight"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["highlight"] = v_23_auto
  highlight = v_23_auto
end
local highlight_21
do
  local v_23_auto
  do
    local v_25_auto = nvim.ex.highlight_
    _1_["highlight!"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["highlight!"] = v_23_auto
  highlight_21 = v_23_auto
end
local hi
do
  local v_23_auto
  do
    local v_25_auto
    local function hi0(group, ...)
      highlight(__(group, ...))
      return group
    end
    v_25_auto = hi0
    _1_["hi"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hi"] = v_23_auto
  hi = v_23_auto
end
local hi_21
do
  local v_23_auto
  do
    local v_25_auto
    local function hi_210(group, ...)
      highlight_21(__(group, ...))
      return group
    end
    v_25_auto = hi_210
    _1_["hi!"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hi!"] = v_23_auto
  hi_21 = v_23_auto
end
local highlight_link
do
  local v_23_auto
  do
    local v_25_auto
    local function highlight_link0(source, target)
      highlight(__("link", source, target))
      return source
    end
    v_25_auto = highlight_link0
    _1_["highlight-link"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["highlight-link"] = v_23_auto
  highlight_link = v_23_auto
end
local highlight_link_21
do
  local v_23_auto
  do
    local v_25_auto
    local function highlight_link_210(source, target)
      highlight_21(__("link", source, target))
      return source
    end
    v_25_auto = highlight_link_210
    _1_["highlight-link!"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["highlight-link!"] = v_23_auto
  highlight_link_21 = v_23_auto
end
local highlight_clear
do
  local v_23_auto
  do
    local v_25_auto
    local function highlight_clear0(group)
      highlight(__("clear", group))
      return group
    end
    v_25_auto = highlight_clear0
    _1_["highlight-clear"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["highlight-clear"] = v_23_auto
  highlight_clear = v_23_auto
end
local highlight_clear_21
do
  local v_23_auto
  do
    local v_25_auto
    local function highlight_clear_210(group)
      highlight_21(__("clear", group))
      return group
    end
    v_25_auto = highlight_clear_210
    _1_["highlight-clear!"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["highlight-clear!"] = v_23_auto
  highlight_clear_21 = v_23_auto
end
local hlclear
do
  local v_23_auto
  do
    local v_25_auto = highlight_clear
    _1_["hlclear"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hlclear"] = v_23_auto
  hlclear = v_23_auto
end
local hlclear_21
do
  local v_23_auto
  do
    local v_25_auto = highlight_clear_21
    _1_["hlclear!"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hlclear!"] = v_23_auto
  hlclear_21 = v_23_auto
end
local rotate
do
  local v_23_auto
  local function rotate0(c, x)
    return c.rotate(x)
  end
  v_23_auto = rotate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["rotate"] = v_23_auto
  rotate = v_23_auto
end
local saturate
do
  local v_23_auto
  local function saturate0(c, x)
    return c.saturate(x)
  end
  v_23_auto = saturate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["saturate"] = v_23_auto
  saturate = v_23_auto
end
local desaturate
do
  local v_23_auto
  local function desaturate0(c, x)
    return c.desaturate(x)
  end
  v_23_auto = desaturate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["desaturate"] = v_23_auto
  desaturate = v_23_auto
end
local lighten
do
  local v_23_auto
  local function lighten0(c, x)
    return c.lighten(x)
  end
  v_23_auto = lighten0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lighten"] = v_23_auto
  lighten = v_23_auto
end
local darken
do
  local v_23_auto
  local function darken0(c, x)
    return c.darken(x)
  end
  v_23_auto = darken0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["darken"] = v_23_auto
  darken = v_23_auto
end
local abs_rotate
do
  local v_23_auto
  local function abs_rotate0(c, x)
    return c.abs_rotate(x)
  end
  v_23_auto = abs_rotate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["abs-rotate"] = v_23_auto
  abs_rotate = v_23_auto
end
local abs_saturate
do
  local v_23_auto
  local function abs_saturate0(c, x)
    return c.abs_saturate(x)
  end
  v_23_auto = abs_saturate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["abs-saturate"] = v_23_auto
  abs_saturate = v_23_auto
end
local abs_desaturate
do
  local v_23_auto
  local function abs_desaturate0(c, x)
    return c.abs_desaturate(x)
  end
  v_23_auto = abs_desaturate0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["abs-desaturate"] = v_23_auto
  abs_desaturate = v_23_auto
end
local abs_lighten
do
  local v_23_auto
  local function abs_lighten0(c, x)
    return c.abs_lighten(x)
  end
  v_23_auto = abs_lighten0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["abs-lighten"] = v_23_auto
  abs_lighten = v_23_auto
end
local abs_darken
do
  local v_23_auto
  local function abs_darken0(c, x)
    return c.abs_darken(x)
  end
  v_23_auto = abs_darken0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["abs-darken"] = v_23_auto
  abs_darken = v_23_auto
end
local hue
do
  local v_23_auto
  local function hue0(c, x)
    return c.hue(x)
  end
  v_23_auto = hue0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["hue"] = v_23_auto
  hue = v_23_auto
end
local saturation
do
  local v_23_auto
  local function saturation0(c, x)
    return c.saturation(x)
  end
  v_23_auto = saturation0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["saturation"] = v_23_auto
  saturation = v_23_auto
end
local lightness
do
  local v_23_auto
  local function lightness0(c, x)
    return c.lightness(x)
  end
  v_23_auto = lightness0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["lightness"] = v_23_auto
  lightness = v_23_auto
end
local h
do
  local v_23_auto
  local function h0(c)
    return a.get(c, "h")
  end
  v_23_auto = h0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["h"] = v_23_auto
  h = v_23_auto
end
local s
do
  local v_23_auto
  local function s0(c)
    return a.get(c, "s")
  end
  v_23_auto = s0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["s"] = v_23_auto
  s = v_23_auto
end
local l
do
  local v_23_auto
  local function l0(c)
    return a.get(c, "l")
  end
  v_23_auto = l0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["l"] = v_23_auto
  l = v_23_auto
end
local function _8_()
  local function _9_(_241)
    return {vim.api.nvim_buf_get_name(_241), vim.api.nvim_buf_get_option(_241, "filetype"), vim.api.nvim_buf_get_option(_241, "buftype")}
  end
  return a.map(_9_, vim.api.nvim_list_bufs())
end
harryg_ = _8_
return nil