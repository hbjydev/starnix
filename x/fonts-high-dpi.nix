#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ pkgs, lib, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      antialias = false;
      hinting.enable = false;
    };
  };

  console = {
    font = "Lat2-Terminus32";
  };
}
