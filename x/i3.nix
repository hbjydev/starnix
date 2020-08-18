{ config, pkgs, lib, vars, ... }:

{
  console.useXkbConfig = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.xserver = {
    displayManager = {
      defaultSession = lib.mkDefault "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      configFile = ../home/.config/i3/config;
      package = pkgs.i3-gaps-rounded;
      extraPackages =
        with pkgs; [
          (polybar.override { pulseSupport = true; }) lxqt.lxqt-policykit
          libnotify dunst xfce.xfce4-settings
        ];
    };
  };
}
