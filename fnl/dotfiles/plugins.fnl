(module dotfiles.plugins
  {require {a aniseed.core
            : packer
            util packer.util
            gen-lab plugins.lab}})

(defn- startup [config plugin-spec rocks-spec]
  (packer.startup
    {1 (fn [use use_rocks]
         (each [k v (ipairs rocks-spec)] (use_rocks v))
         (each [k v (ipairs plugin-spec)] (use v)))
     :config config}))

(def- packer-config
  {:compile_path (util.join_paths (vim.fn.stdpath :config)
                                  :lua :plugins :startup.lua)
   :luarocks {:python_cmd "python3"}
   :profile {:enabled false :threshold 1}
   :log {:level "warn"}})

(def- rocks
  [:lustache :hsluv])

(def- plugins
  {:wbthomason/packer.nvim {}
   :Olical/aniseed {:branch "develop"}
   :lewis6991/impatient.nvim {}

   :tjdevries/astronauta.nvim {:commit "edc19d30a3c51a8c3fc3f606008e5b4238821f1e"
                               :config #(require :astronauta.keymap)}

   :nvim-lua/plenary.nvim {}
   :nvim-lua/popup.nvim {}
   :romgrk/fzy-lua-native {:run "make"}

   :antoinemadec/FixCursorHold.nvim {}
   "~/.config/nvim/localplugin" {:as "harryg"}
   :kyazdani42/nvim-web-devicons {}
   :catppuccin/nvim {:as "catppuccin"}
   :hoob3rt/lualine.nvim {}
   :akinsho/nvim-bufferline.lua {}
   :lukas-reineke/indent-blankline.nvim {}
   :lewis6991/gitsigns.nvim {:requires ["plenary.nvim"]}

   :onsails/lspkind-nvim {}
   :tami5/lspsaga.nvim {}
   :nvim-lua/lsp-status.nvim {}
   :j-hui/fidget.nvim {}
   :folke/trouble.nvim {}
   :neovim/nvim-lspconfig {}

   :L3MON4D3/LuaSnip {}
   :hrsh7th/cmp-nvim-lsp {}
   :hrsh7th/cmp-buffer {}
   :hrsh7th/cmp-path {}
   :hrsh7th/cmp-cmdline {}
   :ray-x/cmp-treesitter {}
   :PaterJason/cmp-conjure {}
   :saadparwaiz1/cmp_luasnip {}
   :hrsh7th/nvim-cmp {}

   :nvim-telescope/telescope-project.nvim {}
   :nvim-telescope/telescope-packer.nvim {}
   :nvim-telescope/telescope-ghq.nvim {}
   :nvim-telescope/telescope-fzf-writer.nvim {}
   :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
   :nvim-telescope/telescope.nvim {:requires ["popup.nvim" "plenary.nvim"]}

   :nvim-treesitter/nvim-treesitter-refactor {}
   :nvim-treesitter/nvim-treesitter-textobjects {}
   :nvim-treesitter/playground {}
   :p00f/nvim-ts-rainbow {}
   :nvim-treesitter/nvim-treesitter {}

   :nvim-neorg/neorg-telescope {}
   :nvim-neorg/neorg {:requires "plenary.nvim"}

   :Olical/conjure {:branch "develop"}
   :tsbohc/zest.nvim {:module "zest"}
   :eraserhd/parinfer-rust {:run "cargo build --release"}

   :akinsho/toggleterm.nvim {}

   :luukvbaal/stabilize.nvim {:config #((. (require :stabilize) :setup))}

   :tpope/vim-commentary {}
   :tpope/vim-repeat {}
   :tpope/vim-surround {}

   :/usr/local/opt/fzf {}
   :junegunn/fzf.vim {}
   :junegunn/vim-slash {}

   :editorconfig/editorconfig-vim {}
   :Raimondi/delimitMate {}
   :sbdchd/neoformat {}

   :LnL7/vim-nix {}
   :bfrg/vim-jq {}
   :fladson/vim-kitty {}
   :nanotee/luv-vimdocs {}
   :bfredl/nvim-luadev {}

   :harrygallagher4/vim-lf {}
   "~/Projects/nvim/nvim-colorizer.lua" {}

   :junegunn/vim-easy-align {:cmd ["EasyAlign" "LiveEasyAlign"]
                             :keys ["<Plug>(EasyAlign)"
                                    "<Plug>(LiveEasyAlign)"
                                    ["v" "<Plug>(EasyAlign)"]
                                    ["v" "<Plug>(LiveEasyAlign)"]]}

   :sindrets/winshift.nvim {:cmd "WinShift"}

   :mhinz/vim-sayonara {:cmd "Sayonara"}

   :windwp/nvim-autopairs {:module "nvim-autopairs"}

   :TravonteD/tree-sitter-fennel {:opt true :run ":TSInstallFromGrammar! fennel"}})

(def- spec
  (->> plugins
    (a.map-indexed
      (fn [[k v]]
        (a.merge [k] v)))))

(startup packer-config spec rocks)

