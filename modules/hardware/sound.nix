{ config, pkgs, lib, ... }:
{
  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "load-module module-switch-on-connect";
    };
  };

  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.enable) [
      pavucontrol
    ];
}
