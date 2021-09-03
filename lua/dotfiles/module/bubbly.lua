local _2afile_2a = "/Users/harry/.config/nvim/fnl/dotfiles/module/bubbly.fnl"
local _0_0
do
  local name_0_ = "dotfiles.module.bubbly"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local autoload = (require("aniseed.autoload")).autoload
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("aniseed.core"), require("aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {["require-macros"] = {["dotfiles.macros"] = true}, require = {a = "aniseed.core", nvim = "aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "dotfiles.module.bubbly"
do local _ = ({nil, _0_0, nil, {{nil}, nil, nil, nil}})[2] end
local term
do
  local v_0_
  local function term0(color)
    return a.get(nvim.g, ("terminal_color_" .. color))
  end
  v_0_ = term0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["term"] = v_0_
  term = v_0_
end
local base
do
  local v_0_
  local function base0(color)
    return ("#" .. a.get(nvim.g, ("base16_gui" .. color)))
  end
  v_0_ = base0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["base"] = v_0_
  base = v_0_
end
-- (set nvim.g.bubbly_palette table: 0x010d6feaf8)
-- (set nvim.g.bubbly_palette table: 0x010d70a3b8)
-- (set nvim.g.bubbly_colors table: 0x010d70de10)
-- (set nvim.g.bubbly_statusline table: 0x010d711230)
-- (if (= vim.g.colors_name zephyr) (set nvim.g.bubbly_palette table: 0x010d723b48) (set nvim.g.bubbly_palette table: 0x010d7296d0))
-- (set nvim.g.bubbly_width table: 0x010d72bd40)
-- (set nvim.g.bubbly_colors table: 0x010d732e78)
return nil