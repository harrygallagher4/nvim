(module dotfiles.module.neoformat
  {require
   {neoformat dotfiles.util.neoformat}})

(tset
  vim.g :neoformat_fennel_fnlfmt
  {:exe "/Users/harry/scripts/fnlfmt"
   :args ["-"]
   :stdin true
   :no_append true})

(tset
  vim.g :neoformat_lua_antifennel
  {:exe "/Users/harry/scripts/antifennel"
   :stdin false
   :no_append false})

(neoformat.init
  {:html        [:prettier]
   :javascript  [:denofmt :prettier]
   :fennel      [:fnlfmt]
   :lua         [:luaformat :antifennel]
   :nix         :nixpkgs-fmt
   :zsh         :shfmt})

