-- ./lua/init.lua
-- CACHE EVERYTHING
local ok, im = pcall(require, 'impatient')
if ok then
  im.enable_profile()
end
require'init'

