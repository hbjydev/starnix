{ pkgs, lib, ... }:
{
  services.journald.extraConfig = lib.mkDefault "SystemMaxUse=500M";

  services.fail2ban = {
    enable = true;
  };

  services.vnstat.enable = true;

  services.fstrim.enable = true; # for ssds
}
