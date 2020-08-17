{ config, pkgs, ... }:
let
  neovimPackages = import ./neovim/default.nix pkgs;
in
{
  environment.systemPackages = neovimPackages;
}
