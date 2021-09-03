#!/usr/bin/env zsh

nix-shell --run "make clean; make; make app"

if [[ -d ./kitty.app ]]; then
  if [[ -d /Applications/kitty.app ]]; then
    trash /Applications/kitty.app
  fi
  mv ./kitty.app /Applications/kitty.app
fi

