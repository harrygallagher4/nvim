-- adapted from @Olical/dotfiles, added support for non-github plugins
local pack_path = vim.fn.stdpath('data') .. '/site/pack'
local fmt = string.format
local function exe(...) vim.cmd(fmt(...)) end

function Plugin(s)
  local repo = table.remove(vim.split(s, '/'))
  local url = s:match'^[^/]+/[^/]+$' and fmt('https://github.com/%s',s) or s
  local install_path = fmt('%s/packer/start/%s', pack_path, repo)
  if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
    exe('"echomsg installing plugin %s..."', s)
    exe('!git clone %s %s', url, install_path)
    exe('packadd %s', repo)
  end
end

-- Bootstrap essential plugins required for installing and loading the rest.
Plugin'wbthomason/packer.nvim'
Plugin'Olical/aniseed'
Plugin'lewis6991/impatient.nvim'

-- require'impatient'
require'plugins.startup'
require'aniseed.env'.init { module = 'dotfiles', compile = false }

