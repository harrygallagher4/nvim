local M = {}

local fn = vim.fn
local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

-- prints install/packadd commands instead of executing them. for testing
function M.Plugin(s)
    local repo = table.remove(vim.split(s, '/'))
    local url = (string.match(s,'^[^/]+/[^/]+$') and fmt('https://github.com/%s',s)) or s
    local install_path = fmt('%s/packer/start/%s', pack_path, repo)
    if fn.empty(fn.glob(install_path)) == 1 then
        print(fmt('cloning plugin %s into %s', s, install_path))
        print(fmt('!git clone %s %s', url, install_path))
        print(fmt('packadd %s', repo))
    else -- this clause should not appear in init.lua version
        print(fmt('detected plugin: %s\nas: %s\nin: %s\n', s, url, install_path))
    end
end

M.Plugin('wbthomason/packer.nvim')
M.Plugin('Olical/aniseed')
M.Plugin('lewis6991/impatient.nvim')
M.Plugin('harrygallagher4/fake.nvim')

vim._scratch = M

