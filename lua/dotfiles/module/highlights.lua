local _2afile_2a = "fnl/dotfiles/module/highlights.fnl"
local _2amodule_name_2a = "dotfiles.module.highlights"
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
local a, colorizer, lush, nvim, str, _, _0 = require("aniseed.core"), require("colorizer"), require("lush"), require("aniseed.nvim"), require("aniseed.string"), nil, nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["colorizer"] = colorizer
_2amodule_locals_2a["lush"] = lush
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["_"] = _0
_2amodule_locals_2a["_"] = _0
colorizer.setup(nil, {names = false, mode = "both"})
local hsl = lush.hsl
_2amodule_locals_2a["hsl"] = hsl
local gruvbox = {dark0_hard = "#1d2021", dark0 = "#282828", dark0_soft = "#32302f", dark1 = "#3c3836", dark2 = "#504945", dark3 = "#665c54", dark4 = "#7c6f64", light0_hard = "#f9f5d7", light0 = "#fbf1c7", light0_soft = "#f2e5bc", light1 = "#ebdbb2", light2 = "#d5c4a1", light3 = "#bdae93", light4 = "#a89984", bright_red = "#fb4934", bright_green = "#b8bb26", bright_yellow = "#fabd2f", bright_blue = "#83a598", bright_purple = "#d3869b", bright_aqua = "#8ec07c", bright_orange = "#fe8019", neutral_red = "#cc241d", neutral_green = "#98971a", neutral_yellow = "#d79921", neutral_blue = "#458588", neutral_purple = "#b16286", neutral_aqua = "#689d6a", neutral_orange = "#d65d0e", faded_red = "#9d0006", faded_green = "#79740e", faded_yellow = "#b57614", faded_blue = "#076678", faded_purple = "#8f3f71", faded_aqua = "#427b58", faded_orange = "#af3a03", gray = "#928374", bg0 = "#32302f", bg1 = "#3c3836", bg2 = "#504945", bg3 = "#665c54", bg4 = "#7c6f64", fg0 = "#fbf1c7", fg1 = "#ebdbb2", fg2 = "#d5c4a1", fg3 = "#bdae93", fg4 = "#a89984", red = "#fb4934", green = "#b8bb26", yellow = "#fabd2f", blue = "#83a598", purple = "#d3869b", aqua = "#8ec07c", orange = "#fe8019", NONE = "NONE", sl = "#32302e"}
_2amodule_2a["gruvbox"] = gruvbox
local function resolve_color(color)
  return (string.match(color, "#%x%x%x%x%x%x") or a.get(gruvbox, color))
end
_2amodule_2a["resolve-color"] = resolve_color
local function lushcolor(color)
  return hsl(resolve_color(color))
end
_2amodule_2a["lushcolor"] = lushcolor
local function __(...)
  return str.join(" ", {...})
end
_2amodule_2a["__"] = __
local function notblank_3f(s)
  return not str["blank?"](s)
end
_2amodule_2a["notblank?"] = notblank_3f
local function fg(color)
  return str.join({"guifg=", resolve_color(color)})
end
_2amodule_2a["fg"] = fg
local function bg(color)
  return str.join({"guibg=", resolve_color(color)})
end
_2amodule_2a["bg"] = bg
local function gui(prop)
  return str.join({"gui=", prop})
end
_2amodule_2a["gui"] = gui
local highlight = nvim.ex.highlight
_2amodule_2a["highlight"] = highlight
local highlight_21 = nvim.ex.highlight_
_2amodule_2a["highlight!"] = highlight_21
local function hi(group, ...)
  highlight(__(group, ...))
  return group
end
_2amodule_2a["hi"] = hi
local function hi_21(group, ...)
  highlight_21(__(group, ...))
  return group
end
_2amodule_2a["hi!"] = hi_21
local function highlight_link(source, target)
  highlight(__("link", source, target))
  return source
end
_2amodule_2a["highlight-link"] = highlight_link
local function highlight_link_21(source, target)
  highlight_21(__("link", source, target))
  return source
end
_2amodule_2a["highlight-link!"] = highlight_link_21
local function highlight_clear(group)
  highlight(__("clear", group))
  return group
end
_2amodule_2a["highlight-clear"] = highlight_clear
local function highlight_clear_21(group)
  highlight_21(__("clear", group))
  return group
end
_2amodule_2a["highlight-clear!"] = highlight_clear_21
local hlclear = highlight_clear
_2amodule_2a["hlclear"] = hlclear
local hlclear_21 = highlight_clear_21
_2amodule_2a["hlclear!"] = hlclear_21
local function rotate(c, x)
  return c.rotate(x)
end
_2amodule_locals_2a["rotate"] = rotate
local function saturate(c, x)
  return c.saturate(x)
end
_2amodule_locals_2a["saturate"] = saturate
local function desaturate(c, x)
  return c.desaturate(x)
end
_2amodule_locals_2a["desaturate"] = desaturate
local function lighten(c, x)
  return c.lighten(x)
end
_2amodule_locals_2a["lighten"] = lighten
local function darken(c, x)
  return c.darken(x)
end
_2amodule_locals_2a["darken"] = darken
local function abs_rotate(c, x)
  return c.abs_rotate(x)
end
_2amodule_locals_2a["abs-rotate"] = abs_rotate
local function abs_saturate(c, x)
  return c.abs_saturate(x)
end
_2amodule_locals_2a["abs-saturate"] = abs_saturate
local function abs_desaturate(c, x)
  return c.abs_desaturate(x)
end
_2amodule_locals_2a["abs-desaturate"] = abs_desaturate
local function abs_lighten(c, x)
  return c.abs_lighten(x)
end
_2amodule_locals_2a["abs-lighten"] = abs_lighten
local function abs_darken(c, x)
  return c.abs_darken(x)
end
_2amodule_locals_2a["abs-darken"] = abs_darken
local function hue(c, x)
  return c.hue(x)
end
_2amodule_locals_2a["hue"] = hue
local function saturation(c, x)
  return c.saturation(x)
end
_2amodule_locals_2a["saturation"] = saturation
local function lightness(c, x)
  return c.lightness(x)
end
_2amodule_locals_2a["lightness"] = lightness
local function h(c)
  return a.get(c, "h")
end
_2amodule_locals_2a["h"] = h
local function s(c)
  return a.get(c, "s")
end
_2amodule_locals_2a["s"] = s
local function l(c)
  return a.get(c, "l")
end
_2amodule_locals_2a["l"] = l
local function _1_()
  local function _2_(_241)
    return {vim.api.nvim_buf_get_name(_241), vim.api.nvim_buf_get_option(_241, "filetype"), vim.api.nvim_buf_get_option(_241, "buftype")}
  end
  return a.map(_2_, vim.api.nvim_list_bufs())
end
harryg_ = _1_
return nil