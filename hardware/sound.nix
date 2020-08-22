#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, pkgs, lib, ... }:
{
  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "load-module module-switch-on-connect
                     load-module module-role-cork";
    };
  };

  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      pavucontrol
    ];
}
