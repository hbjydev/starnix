{ lib, config, pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs;
    let
      polybar = pkgs.polybar.override {
        pulseSupport = true;
      };
    in
      [
        polybar
        jgmenu
        xcape

        lxqt.lxqt-policykit
        libnotify
        dunst
        xfce.xfce4-settings
      ];

  console.useXkbConfig = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.xserver = {
    windowManager.bspwm.enable = true;
    windowManager.bspwm.configFile = ../home/.config/bspwm/bspwmrc;
    windowManager.bspwm.sxhkd.configFile = ../home/.config/sxhkd/sxhkdrc;
    desktopManager.xterm.enable = false;
  };
}
