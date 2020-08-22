#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, pkgs, ... }:
let
  neovimPackages = import ./neovim/default.nix pkgs;
in
{
  environment.systemPackages = neovimPackages;
}
