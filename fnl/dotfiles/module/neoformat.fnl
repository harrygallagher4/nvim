(module dotfiles.module.neoformat
  {require {neoformat dotfiles.util.neoformat}})

(tset
  vim.g :neoformat_fennel_fnlfmt
  {:exe "/Users/harry/scripts/fnlfmt"
   :args ["-"]
   :stdin true
   :no_append true})

(neoformat.init
  {:html        [:prettier]
   :javascript  [:denofmt :prettier]
   :fennel      [:fnlfmt]
   :lua         :luaformat
   :nix         :nixpkgs-fmt
   :zsh         :shfmt})

