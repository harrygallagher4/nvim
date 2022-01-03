local _2afile_2a = "fnl/dotfiles/module/galaxyline.fnl"
local _2amodule_name_2a = "dotfiles.module.galaxyline"
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
local a, devicons, nvim, str, _ = require("aniseed.core"), require("nvim-web-devicons"), require("aniseed.nvim"), require("aniseed.string"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["devicons"] = devicons
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["_"] = _
local function get_file_info()
  return unpack({vim.fn.expand("%:t"), vim.fn.expand("%:e")})
end
_2amodule_locals_2a["get-file-info"] = get_file_info
local function percent(n, d)
  return (math.modf((100 * (n / d))) .. "%")
end
_2amodule_locals_2a["percent"] = percent
local function format_file_size(size)
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
_2amodule_locals_2a["format-file-size"] = format_file_size
local function file_symbol()
  local _2_ = {vim.bo.readonly, vim.bo.filetype, vim.bo.modifiable, vim.bo.modified}
  local function _3_()
    local ft = (_2_)[2]
    local _0 = (_2_)[3]
    local _1 = (_2_)[4]
    return ("help" ~= ft)
  end
  if (((_G.type(_2_) == "table") and ((_2_)[1] == true) and (nil ~= (_2_)[2]) and true and true) and _3_()) then
    local ft = (_2_)[2]
    local _0 = (_2_)[3]
    local _1 = (_2_)[4]
    return "\238\130\162"
  elseif ((_G.type(_2_) == "table") and true and true and ((_2_)[3] == true) and ((_2_)[4] == true)) then
    local _0 = (_2_)[1]
    local _1 = (_2_)[2]
    return "\239\129\128 "
  elseif ((_G.type(_2_) == "table") and true and true and true and true) then
    local _0 = (_2_)[1]
    local _1 = (_2_)[2]
    local _2 = (_2_)[3]
    local _3 = (_2_)[4]
    return nil
  else
    return nil
  end
end
_2amodule_locals_2a["file_symbol"] = file_symbol
local function get_filetype_icon()
  local icon, group = devicons.get_icon(nvim.bo.filetype)
  return (icon or "?")
end
_2amodule_2a["get_filetype_icon"] = get_filetype_icon
local function get_filetype_icon_group()
  local icon, group = devicons.get_icon(nvim.bo.filetype)
  return (group or "Normal")
end
_2amodule_2a["get_filetype_icon_group"] = get_filetype_icon_group
local function get_filetype_icon_fg()
  local icon, group = devicons.get_icon(nvim.bo.filetype)
  if not a["nil?"](group) then
    return string.format("#%x", a.get(vim.api.nvim_get_hl_by_name(group, true), "foreground", 0))
  else
    return "#ffffff"
  end
end
_2amodule_2a["get_filetype_icon_fg"] = get_filetype_icon_fg
local function get_filetype_icon_bg()
  local icon, group = devicons.get_icon(nvim.bo.filetype)
  if not a["nil?"](group) then
    return string.format("#%x", a.get(vim.api.nvim_get_hl_by_name(group, true), "background", 0))
  else
    return "#ffffff"
  end
end
_2amodule_2a["get_filetype_icon_bg"] = get_filetype_icon_bg
local function file_icon()
  return (get_filetype_icon() .. " ")
end
_2amodule_2a["file_icon"] = file_icon
local function file_name()
  local file = vim.fn.expand("%:t")
  if (1 == vim.fn.empty(file)) then
    return ""
  else
    return str.join(" ", a.concat({file}, {file_symbol()}))
  end
end
_2amodule_2a["file_name"] = file_name
local function file_size()
  return format_file_size(vim.fn.getfsize(vim.fn.expand("%:p")))
end
_2amodule_2a["file_size"] = file_size
local function file_encoding()
  if ("" ~= vim.bo.fenc) then
    return vim.bo.fenc
  else
    return vim.o.enc
  end
end
_2amodule_2a["file_encoding"] = file_encoding
local function file_format()
  return vim.bo.fileformat
end
_2amodule_2a["file_format"] = file_format
local function cursor_coordinates()
  return str.join(":", {vim.fn.line("."), vim.fn.col(".")})
end
_2amodule_2a["cursor_coordinates"] = cursor_coordinates
local function cursor_percentage()
  local line = vim.fn.line(".")
  local total = vim.fn.line("$")
  local _9_ = line
  if (_9_ == 1) then
    return "top"
  elseif (_9_ == total) then
    return "bot"
  elseif true then
    local _0 = _9_
    return percent(line, total)
  else
    return nil
  end
end
_2amodule_2a["cursor_percentage"] = cursor_percentage
local function window_number()
  return str.join("", {"\226\157\176", vim.fn.winnr(), "\226\157\177"})
end
_2amodule_2a["window_number"] = window_number
local function buffer_filetype()
  return vim.bo.filetype
end
_2amodule_2a["buffer_filetype"] = buffer_filetype