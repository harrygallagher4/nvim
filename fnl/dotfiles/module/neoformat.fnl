(module dotfiles.module.neoformat
  {require {neoformat dotfiles.util.neoformat}})

(neoformat.init 
  {:html        [:prettier]
   :javascript  [:denofmt :prettier]
   :lua         :luaformat
   :nix         :nixpkgs-fmt
   :zsh         :shfmt})

