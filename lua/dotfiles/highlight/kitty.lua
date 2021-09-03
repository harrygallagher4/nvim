local _2afile_2a = "fnl/dotfiles/highlight/kitty.fnl"
local _1_
do
  local name_4_auto = "dotfiles.highlight.kitty"
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
    return {require("aniseed.core"), require("lustache"), require("aniseed.string")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {require = {a = "aniseed.core", lustache = "lustache", str = "aniseed.string"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local lustache = _local_4_[2]
local str = _local_4_[3]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.highlight.kitty"
do local _ = ({nil, _1_, nil, {{}, nil, nil, nil}})[2] end
local ffffff
do
  local v_23_auto = 16777215
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["ffffff"] = v_23_auto
  ffffff = v_23_auto
end
local min_of
do
  local v_23_auto
  local function min_of0(xs)
    return math.min(unpack(xs))
  end
  v_23_auto = min_of0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["min-of"] = v_23_auto
  min_of = v_23_auto
end
local split_at
do
  local v_23_auto
  local function split_at0(sep, s)
    return str.split(s, sep)
  end
  v_23_auto = split_at0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["split-at"] = v_23_auto
  split_at = v_23_auto
end
local trim_multiline
do
  local v_23_auto
  local function trim_multiline0(s)
    return str.join("\n", a.map(str.trim, split_at("\n", s)))
  end
  v_23_auto = trim_multiline0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["trim-multiline"] = v_23_auto
  trim_multiline = v_23_auto
end
local common_indent
do
  local v_23_auto
  local function common_indent0(s)
    local function _8_(_241)
      return string.match(_241, "^(%s+)%S")
    end
    return min_of(a.map(string.len, a.map(_8_, split_at("\n", s))))
  end
  v_23_auto = common_indent0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["common-indent"] = v_23_auto
  common_indent = v_23_auto
end
local trim_leading_spaces
do
  local v_23_auto
  local function trim_leading_spaces0(indent, input)
    local f
    local function _9_(s)
      if string.match(s, ("^" .. string.rep("%s", indent))) then
        return string.sub(s, (1 + indent))
      elseif string.match(s, "^%s+$") then
        return ""
      else
        return s
      end
    end
    f = _9_
    if a["nil?"](input) then
      return f
    else
      return f(input)
    end
  end
  v_23_auto = trim_leading_spaces0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["trim-leading-spaces"] = v_23_auto
  trim_leading_spaces = v_23_auto
end
local trim_common
do
  local v_23_auto
  local function trim_common0(s)
    local indent = common_indent(s)
    local lines = split_at("\n", s)
    return str.join("\n", a.map(trim_leading_spaces(indent), lines))
  end
  v_23_auto = trim_common0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["trim-common"] = v_23_auto
  trim_common = v_23_auto
end
local tail
do
  local v_23_auto
  local function tail0(xs)
    local _let_12_ = xs
    local h = _let_12_[1]
    local t = {(table.unpack or unpack)(_let_12_, 2)}
    return t
  end
  v_23_auto = tail0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["tail"] = v_23_auto
  tail = v_23_auto
end
local multiline_str
do
  local v_23_auto
  local function multiline_str0(s)
    return trim_common(str.join("\n", a.rest(split_at("\n", s))))
  end
  v_23_auto = multiline_str0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["multiline-str"] = v_23_auto
  multiline_str = v_23_auto
end
local safe_bg
do
  local v_23_auto
  local function safe_bg0(group)
    return string.format("#%06x", a.get(group, "background", ffffff))
  end
  v_23_auto = safe_bg0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["safe-bg"] = v_23_auto
  safe_bg = v_23_auto
end
local safe_fg
do
  local v_23_auto
  local function safe_fg0(group)
    return string.format("#%06x", a.get(group, "foreground", ffffff))
  end
  v_23_auto = safe_fg0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["safe-fg"] = v_23_auto
  safe_fg = v_23_auto
end
local get_bg
do
  local v_23_auto
  local function get_bg0(group)
    if a.get(group, "reverse", false) then
      return safe_fg(group)
    else
      return safe_bg(group)
    end
  end
  v_23_auto = get_bg0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get-bg"] = v_23_auto
  get_bg = v_23_auto
end
local get_fg
do
  local v_23_auto
  local function get_fg0(group)
    if a.get(group, "reverse", false) then
      return safe_bg(group)
    else
      return safe_fg(group)
    end
  end
  v_23_auto = get_fg0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get-fg"] = v_23_auto
  get_fg = v_23_auto
end
local get_hl
do
  local v_23_auto
  local function get_hl0(group)
    local g = vim.api.nvim_get_hl_by_name(group, true)
    return {bg = get_bg(g), fg = get_fg(g)}
  end
  v_23_auto = get_hl0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get-hl"] = v_23_auto
  get_hl = v_23_auto
end
local view
do
  local v_23_auto
  local function _15_(t, k)
    return get_hl(k)
  end
  v_23_auto = setmetatable({["0"] = vim.g.terminal_color_0, ["1"] = vim.g.terminal_color_1, ["10"] = vim.g.terminal_color_10, ["11"] = vim.g.terminal_color_11, ["12"] = vim.g.terminal_color_12, ["13"] = vim.g.terminal_color_13, ["14"] = vim.g.terminal_color_14, ["15"] = vim.g.terminal_color_15, ["2"] = vim.g.terminal_color_2, ["3"] = vim.g.terminal_color_3, ["4"] = vim.g.terminal_color_4, ["5"] = vim.g.terminal_color_5, ["6"] = vim.g.terminal_color_6, ["7"] = vim.g.terminal_color_7, ["8"] = vim.g.terminal_color_8, ["9"] = vim.g.terminal_color_9, scheme_name = vim.g.colors_name}, {__index = _15_})
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["view"] = v_23_auto
  view = v_23_auto
end
local template
do
  local v_23_auto = multiline_str("\n      # generated from nvim colorscheme: {{scheme_name}}\n\n      background {{Normal.bg}}\n      foreground {{Normal.fg}}\n      cursor {{Cursor.bg}}\n      cursor_text_color background\n\n      url_color {{13}}\n\n      selection_background {{Visual.bg}}\n      selection_foreground {{Normal.fg}}\n\n      tab_bar_background {{BufferLineBackground.bg}}\n      active_tab_background {{BufferLineBufferSelected.bg}}\n      active_tab_foreground {{BufferLineBufferSelected.fg}}\n      active_tab_font_style bold-italic\n      inactive_tab_background {{BufferLineBackground.bg}}\n      inactive_tab_foreground {{BufferLineBackground.fg}}\n      inactive_tab_font_style normal\n\n      color0 {{0}}\n      color1 {{1}}\n      color2 {{2}}\n      color3 {{3}}\n      color4 {{4}}\n      color5 {{5}}\n      color6 {{6}}\n      color7 {{7}}\n      color8 {{8}}\n      color9 {{9}}\n      color10 {{10}}\n      color11 {{11}}\n      color12 {{12}}\n      color13 {{13}}\n      color14 {{14}}\n      color15 {{15}}\n    ")
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["template"] = v_23_auto
  template = v_23_auto
end
local fzf_template
do
  local v_23_auto = multiline_str("\n      _gen_fzf_default_opts() {\n      local color00='{{Normal.bg}}'\n      local color01='{{4}}'\n      local color0A='{{6}}'\n      local color0C='{{7}}'\n      local color0D='{{1}}'\n      export FZF_DEFAULT_OPTS=\"$FZF_DEFAULT_OPTS\"\\\n      \" --color=dark,fg+:$color01,bg:$color00,bg+:$color00,gutter:$color00,spinner:$color0C,hl:$color0D,fg:$color04,header:$color0D,info:$color0A,pointer:$color0C,marker:$color0C,prompt:$color0A,hl+:$color0A\"\n      }\n      _gen_fzf_default_opts\n    ")
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["fzf-template"] = v_23_auto
  fzf_template = v_23_auto
end
local generate_kitty
do
  local v_23_auto
  do
    local v_25_auto
    local function generate_kitty0()
      return a.spit("/Users/harry/.config/kitty/nvim_auto_colors.conf", lustache:render(template, view))
    end
    v_25_auto = generate_kitty0
    _1_["generate-kitty"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["generate-kitty"] = v_23_auto
  generate_kitty = v_23_auto
end
local generate_fzf
do
  local v_23_auto
  do
    local v_25_auto
    local function generate_fzf0()
      return a.spit("/Users/harry/.fzf-theme.zsh", lustache:render(fzf_template, view))
    end
    v_25_auto = generate_fzf0
    _1_["generate-fzf"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["generate-fzf"] = v_23_auto
  generate_fzf = v_23_auto
end
return nil