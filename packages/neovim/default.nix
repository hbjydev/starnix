#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ pkgs, lib, ... }:
let
  nvim = pkgs.neovim.override {
    vimAlias = true;

    configure = (import ./customization.nix { pkgs = pkgs; });
  };
in
[ nvim pkgs.python3 pkgs.fzf pkgs.ripgrep pkgs.universal-ctags ]
