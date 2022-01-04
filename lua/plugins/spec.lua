local packer = require('packer')
local util = require('packer.util')

local use = packer.use
local use_rocks = packer.use_rocks
local ex = vim.api.nvim_command
local fn = vim.fn

local packer_config = {
    compile_path = util.join_paths(fn.stdpath('config'), 'lua', 'plugins', 'startup.lua'),
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
        'marko-cerovac/material.nvim', disable = true
    }
    use {
        'folke/tokyonight.nvim'
    }
    use {
        'hoob3rt/lualine.nvim'
    }
    use {
        'nvim-lua/plenary.nvim',
        'tjdevries/astronauta.nvim',
        {
            'norcalli/nvim.lua', -- Don't actually install this as a plugin but just copy the script
            opt = true,          -- to the nvim lua path whenever it's updated which may be never
            run = function(p) ex('!cp '..p.install_path..'/lua/nvim.lua '..fn.stdpath('config')..'/lua/nvim.lua') end
        }
    }
    use {
        'akinsho/nvim-bufferline.lua'
    }
    use {
        'glepnir/galaxyline.nvim', disable = true
    }
    use {
        'oberblastmeister/neuron.nvim', branch = 'unstable'
    }
    use {
        'bfredl/nvim-luadev', -- I don't think I actually use this
        disable = true
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-project.nvim' },
            { 'nvim-telescope/telescope-packer.nvim' },
            { 'nvim-telescope/telescope-ghq.nvim' },
            { 'nvim-telescope/telescope-fzf-writer.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }
    use {
        'onsails/lspkind-nvim',
        'neovim/nvim-lspconfig',
        {
            'ray-x/guihua.lua',
            disable = true,
            run = 'cd lua/fzy && make'
        },
        { 'ray-x/navigator.lua', disable = true },
        { 'ray-x/lsp_signature.nvim', disable = true },
        'folke/lua-dev.nvim',
        'tami5/lspsaga.nvim',
        'nvim-lua/lsp-status.nvim',
        'folke/trouble.nvim',
        'L3MON4D3/LuaSnip',
        {
            'hrsh7th/nvim-compe',
            requires = 'tami5/compe-conjure'
        }
    }
    use {
        'nvim-treesitter/completion-treesitter',
        {
            'nvim-treesitter/nvim-treesitter',
            -- '~/Projects/tree-sitter/nvim-treesitter', as = 'nvim-treesitter',
            requires = {
                { 'nvim-treesitter/nvim-treesitter-refactor' },
                { 'nvim-treesitter/nvim-treesitter-textobjects' },
                { 'nvim-treesitter/playground' },
                { 'p00f/nvim-ts-rainbow' }
            }
        }
    }
    use {
        'nvim-neorg/neorg',
        config = function()
            require('neorg').setup {
                load = {
                    ['core.defaults'] = {},
                    ['core.neorgcmd'] = {},
                    ['core.norg.concealer'] = {},
                    ['core.norg.dirman'] = {
                        config = {
                            workspaces = {
                                my_workspace = '~/neorg'
                            }
                        }
                    }
                }
            }
        end,
        requires = 'nvim-lua/plenary.nvim'
    }
    use {
        {
            'Olical/conjure',
            branch = 'develop'
        },
        {
            'Olical/aniseed',
            branch = 'develop',
            module = 'aniseed.env'
        },
        {
            'tsbohc/zest.nvim',
            module = 'zest',
        }
    }
    use {
        'eraserhd/parinfer-rust',
        run = 'cargo build --release'
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        opt = true
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

        -- need to learn how to use these
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

        { 'gyim/vim-boxdraw', opt = true },

        { 'gelguy/wilder.nvim', opt = true},

        { 'windwp/nvim-autopairs', module = 'nvim-autopairs' },

        -- does not work with ts highlighting
        { 'inkarkat/SyntaxAttr.vim', opt = true }, -- :call SyntaxAttr#SyntaxAttr()

        -- interesting session plugin with telescope support
        {
            { 'rmagatti/auto-session', opt = true },
            { 'rmagatti/session-lens', opt = true }
        }

        -- keep an eye on this mysterious snippets plugin
        --'octaltree/virtualsnip'

    }
end, config = packer_config }

return M
