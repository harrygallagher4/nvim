-- yanked directly from @Olical/dotfiles
local execute = vim.api.nvim_command
local fn = vim.fn
local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

function EnsurePlugin (user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

-- Bootstrap essential plugins required for installing and loading the rest.
EnsurePlugin("wbthomason", "packer.nvim")
EnsurePlugin("Olical", "aniseed")
EnsurePlugin("lewis6991", "impatient.nvim")

-- `init` module is just empty so:
--   1. fennel is compiled
--   2. packer startup sets luarocks path
--   3. impatient runs and caches compiled fennel + luarocks
--   4. dotfiles.init runs
require'aniseed.env'.init { module = 'init', compile = true }
require'plugins.startup'
require'impatient'
require'dotfiles.init'

