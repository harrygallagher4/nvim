local pack_path = vim.fn.stdpath('data') .. '/site/pack'
local fmt = string.format
local function exe(...) vim.cmd(fmt(...)) end

-- Doing this as a single function called 3 times might be just as good, I'm
-- just curious if checking all of the paths immediately would improve
-- performance by luajit skipping the second loop entirely. Then again
-- interacting with the filesystem is probably the major bottleneck here and
-- and likely dwarfs any performance gains from luajit optimizations
function Plugins(plugins)
  local not_installed = {}
  for _, v in ipairs(plugins) do
    local repo = table.remove(vim.split(v, '/'))
    local install_path = fmt('%s/packer/start/%s', pack_path, repo)
    if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
      table.insert(not_installed, { s = v, repo = repo, install_path = install_path })
    end
  end
  for _, v in ipairs(not_installed) do
    local url = v.s:match'^[^/]+/[^/]+$' and fmt('https://github.com/%s', v.s) or v.s
    exe('"echomsg installing plugin %s..."', v.s)
    exe('!git clone %s %s', url, v.install_path)
    exe('packadd %s', v.repo)
  end
end

Plugins {
  'wbthomason/packer.nvim',
  'Olical/aniseed'
}

require'plugins.startup'
require'aniseed.env'.init { module = 'dotfiles', compile = false }

