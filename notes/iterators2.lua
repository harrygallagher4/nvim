local _2afile_2a = "fnl/dotfiles/scratch/iterators.fnl"
local _2amodule_name_2a = "dotfiles.scratch.iterators"
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
local a, fun = require("aniseed.core"), require("fun")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["fun"] = fun
local _local_1_ = string
local reverse = _local_1_["reverse"]
local gmatch = _local_1_["gmatch"]
local len = _local_1_["len"]
local _local_2_ = fun
local iter = _local_2_["iter"]
local map = _local_2_["map"]
local zip = _local_2_["zip"]
local foreach = _local_2_["foreach"]
local function square(state, n)
  if (n < state) then
    local nn = (1 + n)
    return nn, (nn * nn)
  else
    return nil
  end
end
local function squares(up_to)
  return square, up_to, 0
end
local function it_rev_str(s)
  local i = (1 + len(s))
  local it = gmatch(reverse(s), ".")
  local function _4_()
    if (i > 1) then
      i = (i - 1)
      return it(), i
    else
      return nil
    end
  end
  return _4_
end
local function reverse_char_indices(s)
  local _var_6_ = {string.len(s), {}}
  local len0 = _var_6_[1]
  local r = _var_6_[2]
  for c, x in string.gmatch(s:reverse(), ".") do
    table.insert(r, {len0, c})
    len0 = (len0 - 1)
  end
  return r
end
local function fun_clean_vararg(...)
  local args = {...}
  local nargs = select("#", ...)
  local _7_
  local function _8_(_241, _242)
    return {(_241 >= 3), (_242)[(_241 - 2)], (_242)[(_241 - 1)], (_242)[_241]}
  end
  _7_ = _8_(nargs, args)
  if ((_G.type(_7_) == "table") and ((_7_)[1] == true) and ((_G.type((_7_)[2]) == "table") and (nil ~= ((_7_)[2]).param) and (nil ~= ((_7_)[2]).state)) and (((_7_)[2]).param == (_7_)[3]) and (((_7_)[2]).state == (_7_)[4])) then
    local param = ((_7_)[2]).param
    local state = ((_7_)[2]).state
    table.remove(args, nargs)
    table.remove(args, (nargs - 1))
    return (nargs - 2), args
  elseif true then
    local _ = _7_
    return nargs, args
  else
    return nil
  end
end
local function fun_rev_str_gen(s_iter, c)
  if (c > 0) then
    return (c - 1), s_iter(), c
  else
    return nil
  end
end
local function fun_rev_str(s)
  return iter(fun_rev_str_gen, gmatch(reverse(s), "."), len(s))
end
local function fun_multi_wrapper(...)
  return {...}
end
local function fun_wrap_multi(it)
  return map(fun_multi_wrapper, it)
end
local function fun_zip_multi(...)
  local n, args = fun_clean_vararg(...)
  return zip(unpack(a.map(fun_wrap_multi, args)))
end
return _2amodule_2a