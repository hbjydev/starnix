#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
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
      package = pkgs.i3-gaps;
      extraPackages =
        with pkgs; [
          (polybar.override {
            pulseSupport = true;
            i3GapsSupport = true;
          })
          lxqt.lxqt-policykit
          libnotify
          dunst
          xfce.xfce4-settings
        ];
    };
  };
}
