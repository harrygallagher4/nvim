local _2afile_2a = "fnl/dotfiles/highlight/kitty.fnl"
local _2amodule_name_2a = "dotfiles.highlight.kitty"
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
local a, lustache, str = require("aniseed.core"), require("lustache"), require("aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["lustache"] = lustache
_2amodule_locals_2a["str"] = str
local ffffff = 16777215
_2amodule_locals_2a["ffffff"] = ffffff
local function min_of(xs)
  return math.min(unpack(xs))
end
_2amodule_locals_2a["min-of"] = min_of
local function split_at(sep, s)
  return str.split(s, sep)
end
_2amodule_locals_2a["split-at"] = split_at
local function trim_multiline(s)
  return str.join("\n", a.map(str.trim, split_at("\n", s)))
end
_2amodule_locals_2a["trim-multiline"] = trim_multiline
local function common_indent(s)
  local function _1_(_241)
    return string.match(_241, "^(%s+)%S")
  end
  return min_of(a.map(string.len, a.map(_1_, split_at("\n", s))))
end
_2amodule_locals_2a["common-indent"] = common_indent
local function trim_leading_spaces(indent, input)
  local f
  local function _2_(s)
    if string.match(s, ("^" .. string.rep("%s", indent))) then
      return string.sub(s, (1 + indent))
    elseif string.match(s, "^%s+$") then
      return ""
    else
      return s
    end
  end
  f = _2_
  if a["nil?"](input) then
    return f
  else
    return f(input)
  end
end
_2amodule_locals_2a["trim-leading-spaces"] = trim_leading_spaces
local function trim_common(s)
  local indent = common_indent(s)
  local lines = split_at("\n", s)
  return str.join("\n", a.map(trim_leading_spaces(indent), lines))
end
_2amodule_locals_2a["trim-common"] = trim_common
local function tail(xs)
  local _let_5_ = xs
  local h = _let_5_[1]
  local t = (function (t, k) local mt = getmetatable(t) if "table" == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) else return {(table.unpack or unpack)(t, k)} end end)(_let_5_, 2)
  return t
end
_2amodule_locals_2a["tail"] = tail
local function multiline_str(s)
  return trim_common(str.join("\n", a.rest(split_at("\n", s))))
end
_2amodule_locals_2a["multiline-str"] = multiline_str
local function safe_bg(group)
  return string.format("#%06x", a.get(group, "background", ffffff))
end
_2amodule_locals_2a["safe-bg"] = safe_bg
local function safe_fg(group)
  return string.format("#%06x", a.get(group, "foreground", ffffff))
end
_2amodule_locals_2a["safe-fg"] = safe_fg
local function get_bg(group)
  if a.get(group, "reverse", false) then
    return safe_fg(group)
  else
    return safe_bg(group)
  end
end
_2amodule_locals_2a["get-bg"] = get_bg
local function get_fg(group)
  if a.get(group, "reverse", false) then
    return safe_bg(group)
  else
    return safe_fg(group)
  end
end
_2amodule_locals_2a["get-fg"] = get_fg
local function get_hl(group)
  local g = vim.api.nvim_get_hl_by_name(group, true)
  return {bg = get_bg(g), fg = get_fg(g)}
end
_2amodule_locals_2a["get-hl"] = get_hl
local view
local function _8_(t, k)
  return get_hl(k)
end
view = setmetatable({scheme_name = vim.g.colors_name, ["0"] = vim.g.terminal_color_0, ["1"] = vim.g.terminal_color_1, ["2"] = vim.g.terminal_color_2, ["3"] = vim.g.terminal_color_3, ["4"] = vim.g.terminal_color_4, ["5"] = vim.g.terminal_color_5, ["6"] = vim.g.terminal_color_6, ["7"] = vim.g.terminal_color_7, ["8"] = vim.g.terminal_color_8, ["9"] = vim.g.terminal_color_9, ["10"] = vim.g.terminal_color_10, ["11"] = vim.g.terminal_color_11, ["12"] = vim.g.terminal_color_12, ["13"] = vim.g.terminal_color_13, ["14"] = vim.g.terminal_color_14, ["15"] = vim.g.terminal_color_15}, {__index = _8_})
do end (_2amodule_locals_2a)["view"] = view
local template = multiline_str("\n      # generated from nvim colorscheme: {{scheme_name}}\n\n      background {{Normal.bg}}\n      foreground {{Normal.fg}}\n      cursor {{Cursor.bg}}\n      cursor_text_color background\n\n      url_color {{13}}\n\n      selection_background {{Visual.bg}}\n      selection_foreground {{Normal.fg}}\n\n      tab_bar_background {{BufferLineBackground.bg}}\n      active_tab_background {{BufferLineBufferSelected.bg}}\n      active_tab_foreground {{BufferLineBufferSelected.fg}}\n      active_tab_font_style bold-italic\n      inactive_tab_background {{BufferLineBackground.bg}}\n      inactive_tab_foreground {{BufferLineBackground.fg}}\n      inactive_tab_font_style normal\n\n      color0 {{0}}\n      color1 {{1}}\n      color2 {{2}}\n      color3 {{3}}\n      color4 {{4}}\n      color5 {{5}}\n      color6 {{6}}\n      color7 {{7}}\n      color8 {{8}}\n      color9 {{9}}\n      color10 {{10}}\n      color11 {{11}}\n      color12 {{12}}\n      color13 {{13}}\n      color14 {{14}}\n      color15 {{15}}\n    ")
do end (_2amodule_locals_2a)["template"] = template
local fzf_template = multiline_str("\n      _gen_fzf_default_opts() {\n      local color00='{{Normal.bg}}'\n      local color01='{{4}}'\n      local color0A='{{6}}'\n      local color0C='{{7}}'\n      local color0D='{{1}}'\n      export FZF_DEFAULT_OPTS=\"$FZF_DEFAULT_OPTS\"\\\n      \" --color=dark,fg+:$color01,bg:$color00,bg+:$color00,gutter:$color00,spinner:$color0C,hl:$color0D,fg:$color04,header:$color0D,info:$color0A,pointer:$color0C,marker:$color0C,prompt:$color0A,hl+:$color0A\"\n      }\n      _gen_fzf_default_opts\n    ")
do end (_2amodule_locals_2a)["fzf-template"] = fzf_template
local function generate_kitty()
  return a.spit("/Users/harry/.config/kitty/nvim_auto_colors.conf", lustache:render(template, view))
end
_2amodule_2a["generate-kitty"] = generate_kitty
local function generate_fzf()
  return a.spit("/Users/harry/.fzf-theme.zsh", lustache:render(fzf_template, view))
end
_2amodule_2a["generate-fzf"] = generate_fzf