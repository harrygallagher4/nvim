-- adapted from @Olical/dotfiles, added support for non-github plugins
local execute = vim.api.nvim_command
local fn = vim.fn
local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

function Plugin(s)
    local repo = table.remove(vim.split(s, '/'))
    local url = (string.match(s,'^[^/]+/[^/]+$') and fmt('https://github.com/%s',s)) or s
    local install_path = fmt('%s/packer/start/%s', pack_path, repo)
    if fn.empty(fn.glob(install_path)) == 1 then
        execute(fmt('"echomsg installing plugin %s..."', s))
        execute(fmt('!git clone %s %s', url, install_path))
        execute(fmt('packadd %s', repo))
    end
end

-- Bootstrap essential plugins required for installing and loading the rest.
Plugin('wbthomason/packer.nvim')
Plugin('Olical/aniseed')
Plugin('lewis6991/impatient.nvim')

-- `init` module is just empty so:
--   1. fennel is compiled
--   2. packer startup sets luarocks path
--   3. impatient runs and caches compiled fennel + luarocks
--   4. dotfiles.init runs
require'aniseed.env'.init { module = 'init', compile = true }
require'plugins.startup'
require'impatient'
require'dotfiles.init'

