{ pkgs, lib, ... }:
let
  nvim = pkgs.neovim.override {
    vimAlias = true;

    configure = (import ./customization.nix { pkgs = pkgs; });
  };
in
[ nvim pkgs.python3 pkgs.fzf pkgs.ripgrep pkgs.universal-ctags ]
