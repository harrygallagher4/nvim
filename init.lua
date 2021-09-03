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

-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- _G.map_utils = {
--     _returns = {
--         c_n = t'<C-n>',
--         c_p = t'<C-p>',
--         luasnip_jump_next = t'<Plug>luasnip-jump-next',
--         luasnip_jump_prev = t'<Plug>luasnip-jump-prev',
--         luasnip_expand_or_jump = t'<Plug>luasnip-expand-or-jump',
--         tab = t'<Tab>',
--         s_tab = t'<S-Tab>'
--     }
-- }

-- local function compe_complete()
-- 	return vim.fn['compe#complete']()
-- end

-- local function check_back_space()
--     local col = vim.fn.col('.') - 1
--     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--         return true
--     else
--         return false
--     end
-- end

-- -- Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder
-- function map_utils.tab_complete()
--     if vim.fn.pumvisible() == 1 then
--         return map_utils._returns.c_n
--     elseif require'luasnip'.jumpable() then
--         return map_utils._returns.luasnip_jump_next
--     elseif require'luasnip'.expand_or_jumpable() then
--         return map_utils._returns.luasnip_expand_or_jump
--     elseif check_back_space() then
--         return map_utils._returns.tab
--     else
--         return compe_complete()
--     end
-- end

-- function map_utils.s_tab_complete()
--     if vim.fn.pumvisible() == 1 then
--         return map_utils._returns.c_p
--     elseif require'luasnip'.jumpable(-1) then
--         return map_utils._returns.luasnip_jump_prev
--     else
--         return map_utils._returns.s_tab
--     end
-- end

-- vim.api.nvim_set_keymap("i", "<Tab>",   "v:lua.map_utils.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.map_utils.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>",   "<cmd>lua require'luasnip'.jump(1)<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<cr>", {silent = true, noremap = true})



-- require 'plugins'

