{ config, pkgs, ... }:
{
  services.xserver.windowManager.bspwm = {
    enable = true;
    configFile = ../../home/.config/bspwm/bspwmrc;
    sxhkd.configFile = ../../home/.config/sxhkd/sxhkdrc;
  };

  environment.systemPackages = with pkgs; [ sxhkd ];
}
