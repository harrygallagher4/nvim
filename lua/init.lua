-- adapted from @Olical/dotfiles, added support for non-github plugins
local pack_path = vim.fn.stdpath('data') .. '/site/pack'
local fmt = string.format
local function exe(...) vim.cmd(fmt(...)) end

local function github_repo_or_url(s)
  return s:match'^[^/]+/[^/]+$' and fmt('https://github.com/%s', s) or s
end

local function has_start_plugin(name)
  local install_path = fmt('%s/packer/start/%s', pack_path, name)
  return (vim.fn.empty(vim.fn.glob(install_path)) == 1), install_path
end

function Plugin(s)
  local plugin_name = table.remove(vim.split(s, '/'))
  local url = github_repo_or_url(s)
  local empty, install_path = has_start_plugin(plugin_name)
  if empty then
    exe('"echomsg installing plugin %s..."', s)
    exe('!git clone %s %s', url, install_path)
    exe('packadd %s', plugin_name)
  end
end

-- Bootstrap essential plugins required for installing and loading the rest.
Plugin'wbthomason/packer.nvim'
Plugin'Olical/aniseed'

require'plugins.startup'
require'aniseed.env'.init { module = 'dotfiles', compile = false }

