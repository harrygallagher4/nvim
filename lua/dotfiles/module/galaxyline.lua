local _2afile_2a = "fnl/dotfiles/module/galaxyline.fnl"
local _1_
do
  local name_4_auto = "dotfiles.module.galaxyline"
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
    return {require("aniseed.core"), require("nvim-web-devicons"), require("aniseed.nvim"), require("aniseed.string")}
  end
  ok_3f_21_auto, val_22_auto = pcall(_5_)
  if ok_3f_21_auto then
    _1_["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", devicons = "nvim-web-devicons", nvim = "aniseed.nvim", str = "aniseed.string"}}
    return val_22_auto
  else
    return print(val_22_auto)
  end
end
local _local_4_ = _6_(...)
local a = _local_4_[1]
local devicons = _local_4_[2]
local nvim = _local_4_[3]
local str = _local_4_[4]
local _2amodule_2a = _1_
local _2amodule_name_2a = "dotfiles.module.galaxyline"
do local _ = ({nil, _1_, nil, {{nil}, nil, nil, nil}})[2] end
local get_file_info
do
  local v_23_auto
  local function get_file_info0()
    return unpack({vim.fn.expand("%:t"), vim.fn.expand("%:e")})
  end
  v_23_auto = get_file_info0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get-file-info"] = v_23_auto
  get_file_info = v_23_auto
end
local percent
do
  local v_23_auto
  local function percent0(n, d)
    return (math.modf((100 * (n / d))) .. "%")
  end
  v_23_auto = percent0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["percent"] = v_23_auto
  percent = v_23_auto
end
local format_file_size
do
  local v_23_auto
  local function format_file_size0(size)
    if (size < (1024 ^ 0)) then
      return ""
    elseif (size < (1024 ^ 1)) then
      return (size .. "b")
    elseif (size < (1024 ^ 2)) then
      return (string.format("%.1f", (size / (1024 ^ 1))) .. "k")
    elseif (size < (1024 ^ 3)) then
      return (string.format("%.1f", (size / (1024 ^ 2))) .. "m")
    else
      return (string.format("%.1f", (size / (1024 ^ 3))) .. "\227\142\135")
    end
  end
  v_23_auto = format_file_size0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["format-file-size"] = v_23_auto
  format_file_size = v_23_auto
end
local file_symbol
do
  local v_23_auto
  local function file_symbol0()
    local _9_ = {vim.bo.readonly, vim.bo.filetype, vim.bo.modifiable, vim.bo.modified}
    local function _10_()
      local ft = (_9_)[2]
      local _ = (_9_)[3]
      local _0 = (_9_)[4]
      return ("help" ~= ft)
    end
    if (((type(_9_) == "table") and ((_9_)[1] == true) and (nil ~= (_9_)[2]) and true and true) and _10_()) then
      local ft = (_9_)[2]
      local _ = (_9_)[3]
      local _0 = (_9_)[4]
      return "\238\130\162"
    elseif ((type(_9_) == "table") and true and true and ((_9_)[3] == true) and ((_9_)[4] == true)) then
      local _ = (_9_)[1]
      local _0 = (_9_)[2]
      return "\239\129\128 "
    elseif ((type(_9_) == "table") and true and true and true and true) then
      local _ = (_9_)[1]
      local _0 = (_9_)[2]
      local _1 = (_9_)[3]
      local _2 = (_9_)[4]
      return nil
    end
  end
  v_23_auto = file_symbol0
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["file_symbol"] = v_23_auto
  file_symbol = v_23_auto
end
local get_filetype_icon
do
  local v_23_auto
  do
    local v_25_auto
    local function get_filetype_icon0()
      local icon, group = devicons.get_icon(nvim.bo.filetype)
      return (icon or "?")
    end
    v_25_auto = get_filetype_icon0
    _1_["get_filetype_icon"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get_filetype_icon"] = v_23_auto
  get_filetype_icon = v_23_auto
end
local get_filetype_icon_group
do
  local v_23_auto
  do
    local v_25_auto
    local function get_filetype_icon_group0()
      local icon, group = devicons.get_icon(nvim.bo.filetype)
      return (group or "Normal")
    end
    v_25_auto = get_filetype_icon_group0
    _1_["get_filetype_icon_group"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get_filetype_icon_group"] = v_23_auto
  get_filetype_icon_group = v_23_auto
end
local get_filetype_icon_fg
do
  local v_23_auto
  do
    local v_25_auto
    local function get_filetype_icon_fg0()
      local icon, group = devicons.get_icon(nvim.bo.filetype)
      if not a["nil?"](group) then
        return string.format("#%x", a.get(vim.api.nvim_get_hl_by_name(group, true), "foreground", 0))
      else
        return "#ffffff"
      end
    end
    v_25_auto = get_filetype_icon_fg0
    _1_["get_filetype_icon_fg"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get_filetype_icon_fg"] = v_23_auto
  get_filetype_icon_fg = v_23_auto
end
local get_filetype_icon_bg
do
  local v_23_auto
  do
    local v_25_auto
    local function get_filetype_icon_bg0()
      local icon, group = devicons.get_icon(nvim.bo.filetype)
      if not a["nil?"](group) then
        return string.format("#%x", a.get(vim.api.nvim_get_hl_by_name(group, true), "background", 0))
      else
        return "#ffffff"
      end
    end
    v_25_auto = get_filetype_icon_bg0
    _1_["get_filetype_icon_bg"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["get_filetype_icon_bg"] = v_23_auto
  get_filetype_icon_bg = v_23_auto
end
local file_icon
do
  local v_23_auto
  do
    local v_25_auto
    local function file_icon0()
      return (get_filetype_icon() .. " ")
    end
    v_25_auto = file_icon0
    _1_["file_icon"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["file_icon"] = v_23_auto
  file_icon = v_23_auto
end
local file_name
do
  local v_23_auto
  do
    local v_25_auto
    local function file_name0()
      local file = vim.fn.expand("%:t")
      if (1 == vim.fn.empty(file)) then
        return ""
      else
        return str.join(" ", a.concat({file}, {file_symbol()}))
      end
    end
    v_25_auto = file_name0
    _1_["file_name"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["file_name"] = v_23_auto
  file_name = v_23_auto
end
local file_size
do
  local v_23_auto
  do
    local v_25_auto
    local function file_size0()
      return format_file_size(vim.fn.getfsize(vim.fn.expand("%:p")))
    end
    v_25_auto = file_size0
    _1_["file_size"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["file_size"] = v_23_auto
  file_size = v_23_auto
end
local file_encoding
do
  local v_23_auto
  do
    local v_25_auto
    local function file_encoding0()
      if ("" ~= vim.bo.fenc) then
        return vim.bo.fenc
      else
        return vim.o.enc
      end
    end
    v_25_auto = file_encoding0
    _1_["file_encoding"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["file_encoding"] = v_23_auto
  file_encoding = v_23_auto
end
local file_format
do
  local v_23_auto
  do
    local v_25_auto
    local function file_format0()
      return vim.bo.fileformat
    end
    v_25_auto = file_format0
    _1_["file_format"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["file_format"] = v_23_auto
  file_format = v_23_auto
end
local cursor_coordinates
do
  local v_23_auto
  do
    local v_25_auto
    local function cursor_coordinates0()
      return str.join(":", {vim.fn.line("."), vim.fn.col(".")})
    end
    v_25_auto = cursor_coordinates0
    _1_["cursor_coordinates"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["cursor_coordinates"] = v_23_auto
  cursor_coordinates = v_23_auto
end
local cursor_percentage
do
  local v_23_auto
  do
    local v_25_auto
    local function cursor_percentage0()
      local line = vim.fn.line(".")
      local total = vim.fn.line("$")
      local _16_ = line
      if (_16_ == 1) then
        return "top"
      elseif (_16_ == total) then
        return "bot"
      else
        local _ = _16_
        return percent(line, total)
      end
    end
    v_25_auto = cursor_percentage0
    _1_["cursor_percentage"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["cursor_percentage"] = v_23_auto
  cursor_percentage = v_23_auto
end
local window_number
do
  local v_23_auto
  do
    local v_25_auto
    local function window_number0()
      return str.join("", {"\226\157\176", vim.fn.winnr(), "\226\157\177"})
    end
    v_25_auto = window_number0
    _1_["window_number"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["window_number"] = v_23_auto
  window_number = v_23_auto
end
local buffer_filetype
do
  local v_23_auto
  do
    local v_25_auto
    local function buffer_filetype0()
      return vim.bo.filetype
    end
    v_25_auto = buffer_filetype0
    _1_["buffer_filetype"] = v_25_auto
    v_23_auto = v_25_auto
  end
  local t_24_auto = (_1_)["aniseed/locals"]
  t_24_auto["buffer_filetype"] = v_23_auto
  buffer_filetype = v_23_auto
end
return nil