local packer = require('packer')
local util = require('packer.util')

local use = packer.use
local use_rocks = packer.use_rocks
local ex = vim.api.nvim_command
local fn = vim.fn

local packer_config = {
    compile_path = util.join_paths(fn.stdpath('config'),'lua','plugins','startup.lua'),
    luarocks = {
        python_cmd = 'python3'
    }
}

local M = packer.startup { function()
    use_rocks 'lustache'
    use_rocks 'hsluv'

    use {
        'wbthomason/packer.nvim'
    }
    use {
        'antoinemadec/FixCursorHold.nvim'
    }
    use {
        '~/.config/nvim/localplugin', as = 'harryg'
    }
    use {
        'kyazdani42/nvim-web-devicons'
    }
    use {
        'rktjmp/lush.nvim'
    }
    use {
        'savq/melange'
    }
    use {
        'folke/tokyonight.nvim'
    }
    use {
        'hoob3rt/lualine.nvim'
    }
    use { -- this is deprecated
        'tjdevries/astronauta.nvim',
        commit = 'edc19d30a3c51a8c3fc3f606008e5b4238821f1e'
    }
    use { -- libraries/dependencies
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        { 'romgrk/fzy-lua-native', run = 'make' }
    }
    use {
        'akinsho/nvim-bufferline.lua'
    }
    use {
        'oberblastmeister/neuron.nvim', branch = 'unstable'
    }
    use {
        'bfredl/nvim-luadev',
    }
    use { -- Telescope
        'nvim-telescope/telescope.nvim',
        requires = {
            'popup.nvim',
            'plenary.nvim',
            { 'nvim-telescope/telescope-project.nvim' },
            { 'nvim-telescope/telescope-packer.nvim' },
            { 'nvim-telescope/telescope-ghq.nvim' },
            { 'nvim-telescope/telescope-fzf-writer.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }
    use { -- LSP
        'onsails/lspkind-nvim',
        'neovim/nvim-lspconfig',
        -- go to definition/references in floating window
        -- 'rmagatti/goto-preview',
        'tami5/lspsaga.nvim',
        'nvim-lua/lsp-status.nvim',
        'folke/trouble.nvim',
    }
    use { -- completion, sources, & snippets
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'ray-x/cmp-treesitter',
        'PaterJason/cmp-conjure',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/nvim-cmp',
    }
    use { -- treesitter
        'nvim-treesitter/nvim-treesitter',
        -- '~/Projects/tree-sitter/nvim-treesitter', as = 'nvim-treesitter',
        requires = {
            { 'nvim-treesitter/nvim-treesitter-refactor' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'nvim-treesitter/playground' },
            { 'p00f/nvim-ts-rainbow' }
        }
    }
    use { -- This wil never be loaded I just want to keep it up to date
        'TravonteD/tree-sitter-fennel', opt = true,
        run = ':TSInstallFromGrammar! fennel'
    }
    use {
        'nvim-neorg/neorg',
        config = function()
            require('neorg').setup {
                load = { ['core.defaults']={},['core.neorgcmd']={},['core.norg.concealer']={},
                    ['core.norg.dirman'] = { config = { workspaces = { my_workspace = '~/neorg' } } }
                }
            }
        end,
        requires = 'plenary.nvim'
    }
    use { -- fennel stuff
        { 'Olical/conjure', branch = 'develop' },
        { 'Olical/aniseed', branch = 'develop', module = 'aniseed.env' },
        { 'tsbohc/zest.nvim', module = 'zest', }
    }
    use {
        'eraserhd/parinfer-rust',
        run = 'cargo build --release'
    }
    use {
        'lukas-reineke/indent-blankline.nvim', opt = true
    }
    use {
        'https://gitlab.com/yorickpeterse/nvim-pqf.git', as = 'nvim-pqf',
        config = function () require'pqf'.setup() end
    }
    use {
        'tpope/vim-repeat',
        'tpope/vim-commentary',
        'tpope/vim-surround',

        '/usr/local/opt/fzf',
        'junegunn/fzf.vim',
        'junegunn/vim-slash',

        'editorconfig/editorconfig-vim',
        'Raimondi/delimitMate',
        'sbdchd/neoformat',
        'LnL7/vim-nix',
        'bfrg/vim-jq',
        'harrygallagher4/vim-lf',
        '~/Projects/nvim/nvim-colorizer.lua',

        'nanotee/luv-vimdocs',

        --
        -- need to learn how to use plugins below here
        -- ===========================================
        --

        -- not sure about tabular vs. vim-easy-align
        -- 'godlygeek/tabular',
        {
            'junegunn/vim-easy-align',
            keys = {'<Plug>(EasyAlign)','<Plug>(LiveEasyAlign)',{'v','<Plug>(EasyAlign)'},{'v','<Plug>(LiveEasyAlign)'}},
            cmd = {'EasyAlign','LiveEasyAlign'}
        },

        {
            'mhinz/vim-sayonara',
            cmd = {'Sayonara'}
        },

        { 'windwp/nvim-autopairs', module = 'nvim-autopairs' },
    }
end, config = packer_config }

local disabledPlugins = function()
    use {
        'marko-cerovac/material.nvim'
    }
    use {
        'glepnir/galaxyline.nvim'
    }
    use { -- ray-x has a whole little system implemented but I found it somewhat confusing
        { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
        { 'ray-x/navigator.lua' },
        { 'ray-x/lsp_signature.nvim' },
    }
    use { -- I'd like to switch to this but it isn't a drop-in replacement for parinfer-rust
        'gpanders/nvim-parinfer',
        config = function ()
            vim.g.parinfer_no_maps = 1
        end
    }
    -- couldn't get this to work at all
    use { 'gelguy/wilder.nvim' }
    -- does not work with ts highlighting
    use { 'inkarkat/SyntaxAttr.vim' } -- :call SyntaxAttr#SyntaxAttr()
    -- keep an eye on this mysterious snippets plugin
    use 'octaltree/virtualsnip'
    use { 'gyim/vim-boxdraw' }
    -- interesting session plugin with telescope support
    use {
        { 'rmagatti/auto-session' },
        { 'rmagatti/session-lens' }
    }
end

return M
