_G.nvim = require'nvim'

vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.g.node_host_prog = '/Users/harry/.config/yarn/global/node_modules/neovim/bin/cli.js'
vim.o.termguicolors = true
if vim.g.uivonim == 1 or vim.g.goneovim == 1 then
    vim.o.guifont = "Iosevka Nerd Font:h15"
    vim.o.linespace = 3
end
vim.g.cursorhold_updatetime = 100

vim.cmd 'source ~/.config/nvim/rc.vim'

require'plugins.startup'
require'aniseed.env'.init()

