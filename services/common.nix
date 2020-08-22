#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ pkgs, lib, ... }:
{
  services.journald.extraConfig = lib.mkDefault "SystemMaxUse=500M";

  services.fail2ban = {
    enable = true;
  };

  services.vnstat.enable = true;

  services.fstrim.enable = true; # for ssds
}
