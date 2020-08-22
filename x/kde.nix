#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, pkgs, lib, vars, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.gdm.enable = lib.mkForce false;

  services.xserver.desktopManager.plasma5.enable = true;
}
