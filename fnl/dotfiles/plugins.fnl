(module dotfiles.plugins
  {require
   {p packer
    a aniseed.core
    util dotfiles.util}})

; :profile {:enabled false :threshold 1}
; :display {:non_interactive true}
(def- packer-config
  {:compile_path (util.stdfile :config :lua :plugins :startup.lua)
   :max_jobs 32
   :ensure_dependencies true
   :git {:cmd "/usr/local/bin/git"}
   :log {:level "trace"}})

(def- rocks
  [:lustache :hsluv :fun])

(def- plugin-list
  [:wbthomason/packer.nvim
   :Olical/aniseed {:lock true}
   :lewis6991/impatient.nvim

   :tjdevries/astronauta.nvim {:commit "edc19d30a3c51a8c3fc3f606008e5b4238821f1e"
                               :config #(require :astronauta.keymap)}

   :nvim-lua/plenary.nvim
   :nvim-lua/popup.nvim

   :andweeb/presence.nvim {:module "presence"}

   :kyazdani42/nvim-web-devicons
   :catppuccin/nvim {:as "catppuccin"}
   :hoob3rt/lualine.nvim
   :feline-nvim/feline.nvim
   :akinsho/nvim-bufferline.lua
   :lukas-reineke/indent-blankline.nvim
   :lewis6991/gitsigns.nvim {:requires ["plenary.nvim"]}
   :rcarriga/nvim-notify

   :onsails/lspkind-nvim
   :tami5/lspsaga.nvim {:module "lspsaga"}
   :j-hui/fidget.nvim
   :folke/trouble.nvim
   :neovim/nvim-lspconfig

   :L3MON4D3/LuaSnip
   :hrsh7th/cmp-nvim-lsp
   :hrsh7th/cmp-buffer
   :hrsh7th/cmp-path
   :hrsh7th/cmp-cmdline
   :ray-x/cmp-treesitter
   :PaterJason/cmp-conjure
   ; :saadparwaiz1/cmp_luasnip
   :hrsh7th/nvim-cmp

   :nvim-telescope/telescope-project.nvim
   :nvim-telescope/telescope-packer.nvim
   :nvim-telescope/telescope-ghq.nvim
   :jvgrootveld/telescope-zoxide
   :romgrk/fzy-lua-native {:run "make"}
   :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
   :natecraddock/telescope-zf-native.nvim
   :nvim-telescope/telescope.nvim {:requires ["popup.nvim" "plenary.nvim"]}

   :harrygallagher4/aniseed-ts-queries.nvim
   :nvim-treesitter/nvim-treesitter-refactor
   :nvim-treesitter/nvim-treesitter-textobjects
   :nvim-treesitter/playground
   :p00f/nvim-ts-rainbow
   :nvim-treesitter/nvim-treesitter

   :nvim-neorg/neorg-telescope
   :nvim-neorg/neorg {:requires "plenary.nvim"}

   :Olical/conjure {:branch "develop"}
   :tsbohc/zest.nvim {:module "zest"}
   :eraserhd/parinfer-rust {:opt true :run "cargo build --release"}

   :ggandor/lightspeed.nvim

   :akinsho/toggleterm.nvim

   "https://gitlab.com/yorickpeterse/nvim-pqf"
   {:config #((. (require :pqf) :setup))}

   :luukvbaal/stabilize.nvim {:opt true
                              :config #((. (require :stabilize) :setup))}

   :tpope/vim-commentary
   :tpope/vim-repeat
   :tpope/vim-surround

   :/usr/local/opt/fzf
   :junegunn/fzf.vim

   :edluffy/specs.nvim

   :gpanders/editorconfig.nvim
   :Raimondi/delimitMate
   :sbdchd/neoformat

   :LnL7/vim-nix
   :bfrg/vim-jq
   :fladson/vim-kitty
   :nanotee/luv-vimdocs
   :bfredl/nvim-luadev

   ; :is0n/fm-nvim
   :harrygallagher4/vim-lf
   "~/Projects/nvim/nvim-colorizer.lua"

   :mizlan/iswap.nvim {:cmd [:ISwap :ISwapWith]
                       :keys [:<Plug>ISwapNormal :<Plug>ISwapWith]
                       :config #(require "dotfiles.plugin.iswap")}

   :ThePrimeagen/jvim.nvim {:ft ["json" "jsonc"]}

   :sindrets/diffview.nvim {:cmd
                            [:DiffviewOpen :DiffviewClose :DiffviewToggleFiles
                             :DiffviewFocusFiles :DiffviewRefresh
                             :DiffviewFileHistory]}

   :junegunn/vim-easy-align {:cmd ["EasyAlign" "LiveEasyAlign"]
                             :keys ["<Plug>(EasyAlign)"
                                    "<Plug>(LiveEasyAlign)"
                                    ["v" "<Plug>(EasyAlign)"]
                                    ["v" "<Plug>(LiveEasyAlign)"]]}

   ; sort of "window manager" for nvim, resizes windows as focus changes
   ; seems interesting but would probably need a good amount of configuration
   :beauwilliams/focus.nvim {:module "focus"}

   :sindrets/winshift.nvim {:cmd "WinShift"}

   :mhinz/vim-sayonara {:cmd "Sayonara"}

   :windwp/nvim-autopairs {:module "nvim-autopairs"}

   :TravonteD/tree-sitter-fennel {:opt true :run ":TSInstallFromGrammar! fennel"}

   :rktjmp/lush.nvim {:module "lush"}])


(defn- plugin-list-to-map [plugins]
  (accumulate [tbl {} k v (ipairs plugins)]
    (if (a.string? v)
        (a.assoc tbl v {})
        (a.assoc tbl (a.get plugins (- k 1)) v))))

(defn- plugin-map-to-spec [plugins]
  (->> plugins (a.map-indexed
                 (fn [[k v]]
                   (a.merge [k] v)))))

(defn- startup [config plugin-spec rocks-spec]
  (p.startup
    {1 (fn [use use_rocks]
         (each [k v (ipairs rocks-spec)] (use_rocks v))
         (each [k v (ipairs plugin-spec)] (use v)))
     :config config}))

(def packer
  (startup packer-config
           (-> plugin-list (plugin-list-to-map) (plugin-map-to-spec))
           rocks))

; (def clean packer.clean)
; (def compile packer.compile)
; (def install packer.install)
; (def load-plugin packer.loader)
; (def loader packer.loader)
; (def status packer.status)
; (def sync packer.sync)
; (def update packer.update)

