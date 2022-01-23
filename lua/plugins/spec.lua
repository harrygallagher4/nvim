local packer = require('packer')
local util = require('packer.util')

local use = packer.use
local use_rocks = packer.use_rocks
local lab = require('plugins.lab')(use)

local packer_config = {
    compile_path = util.join_paths(vim.fn.stdpath'config','lua','plugins','startup.lua'),
    luarocks = { python_cmd = 'python3' },
    profile = { enable = false, threshold = 1 },
    log = { level = 'warn' }
}

local M = packer.startup { function()
    use_rocks 'lustache'
    use_rocks 'hsluv'

    use { 'wbthomason/packer.nvim' }
    use { 'Olical/aniseed', branch = 'develop' }
    use { 'lewis6991/impatient.nvim' }

    use {
        'tjdevries/astronauta.nvim', commit = 'edc19d30a3c51a8c3fc3f606008e5b4238821f1e',
        config = function() require('astronauta.keymap') end
    }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-lua/popup.nvim' }
    use { 'romgrk/fzy-lua-native', run = 'make' }

    use { 'antoinemadec/FixCursorHold.nvim' }
    use { '~/.config/nvim/localplugin', as = 'harryg' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use { 'hoob3rt/lualine.nvim' }
    use { 'akinsho/nvim-bufferline.lua' }
    use { 'lukas-reineke/indent-blankline.nvim' }

    ----- this is probably worth installing
    -- 'williamboman/nvim-lsp-installer',
    ----- go to definition/references in floating window
    -- 'rmagatti/goto-preview',
    use { 'onsails/lspkind-nvim' }
    use { 'tami5/lspsaga.nvim' }
    use { 'nvim-lua/lsp-status.nvim' }
    use { 'folke/trouble.nvim' }
    use { 'neovim/nvim-lspconfig' }

    use { 'L3MON4D3/LuaSnip' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'ray-x/cmp-treesitter' }
    use { 'PaterJason/cmp-conjure' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/nvim-cmp' }

    use { 'nvim-telescope/telescope-project.nvim' }
    use { 'nvim-telescope/telescope-packer.nvim' }
    use { 'nvim-telescope/telescope-ghq.nvim' }
    use { 'nvim-telescope/telescope-fzf-writer.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope.nvim', requires = { 'popup.nvim', 'plenary.nvim' } }

    use { 'nvim-treesitter/nvim-treesitter-refactor' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use { 'nvim-treesitter/playground' }
    use { 'p00f/nvim-ts-rainbow' }
    use { 'nvim-treesitter/nvim-treesitter' }

    use { 'nvim-neorg/neorg-telescope' }
    use { 'nvim-neorg/neorg', requires = 'plenary.nvim' }

    use { 'Olical/conjure', branch = 'develop' }
    use { 'tsbohc/zest.nvim', module = 'zest' }
    use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }

    use { 'akinsho/toggleterm.nvim' }

    use {
        'luukvbaal/stabilize.nvim',
        config = function () require'stabilize'.setup() end
    }
    lab {
        'yorickpeterse/nvim-pqf',
        config = function () require'pqf'.setup() end
    }

    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-surround' }
--  use 'blackCauldron7/surround.nvim',

    use { '/usr/local/opt/fzf' }
    use { 'junegunn/fzf.vim' }
    use { 'junegunn/vim-slash' }

    use { 'editorconfig/editorconfig-vim' }
    use { 'Raimondi/delimitMate' }
    use { 'sbdchd/neoformat' }

    use { 'LnL7/vim-nix' }
    use { 'bfrg/vim-jq' }
    use { 'fladson/vim-kitty' }
    use { 'nanotee/luv-vimdocs' }
    use { 'bfredl/nvim-luadev' }

    use { 'harrygallagher4/vim-lf' }
    use { '~/Projects/nvim/nvim-colorizer.lua' }
    --
    -- need to learn how to use plugins below here
    -- ===========================================
    --

    -- not sure about tabular vs. vim-easy-align
    -- 'godlygeek/tabular',
    use {
        'junegunn/vim-easy-align',
        keys = {'<Plug>(EasyAlign)','<Plug>(LiveEasyAlign)',{'v','<Plug>(EasyAlign)'},{'v','<Plug>(LiveEasyAlign)'}},
        cmd = {'EasyAlign','LiveEasyAlign'}
    }

    use { 'sindrets/winshift.nvim', cmd = 'WinShift' }

    use { 'mhinz/vim-sayonara', cmd = 'Sayonara' }

    use { 'windwp/nvim-autopairs', module = 'nvim-autopairs' }
    -- This wil never be loaded I just want to keep it up to date
    use { 'TravonteD/tree-sitter-fennel', opt = true, run = ':TSInstallFromGrammar! fennel' }

end, config = packer_config }

local disabledPlugins = function()
    use 'marko-cerovac/material.nvim'
    use 'glepnir/galaxyline.nvim'
    -- ray-x has a whole little system implemented but I found it somewhat confusing
    use {
        { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
        'ray-x/navigator.lua',
        'ray-x/lsp_signature.nvim',
    }
    -- I'd like to switch to this but it isn't a drop-in replacement for parinfer-rust
    use { 'gpanders/nvim-parinfer', config = function () vim.g.parinfer_no_maps = 1 end }
    -- couldn't get this to work at all
    use 'gelguy/wilder.nvim'
    -- does not work with ts highlighting
    use 'inkarkat/SyntaxAttr.vim' -- :call SyntaxAttr#SyntaxAttr()
    -- keep an eye on this mysterious snippets plugin
    use 'octaltree/virtualsnip'
    use 'gyim/vim-boxdraw'
    -- interesting session plugin with telescope support
    use 'rmagatti/auto-session'
    use 'rmagatti/session-lens'
    use 'rktjmp/lush.nvim'
    use 'savq/melange'
    use 'folke/tokyonight.nvim'
    use { 'oberblastmeister/neuron.nvim', branch = 'unstable', opt = true }
end

return M
