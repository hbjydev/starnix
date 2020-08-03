{ config, pkgs, lib, vars, ... }:

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
    displayManager = {
      defaultSession = lib.mkDefault "none+xmonad";
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  # Polybar Integ
  systemd.tmpfiles.rules =
    [
      "p+ /tmp/.xmonad-workspace-log 0600 1000 users"
    ];

  home-manager = {
    users.${vars.user} = {
      xsession.windowManager.xmonad.enable = true;
      xsession.windowManager.xmonad.enableContribAndExtras = true;
      xsession.windowManager.xmonad.config = lib.mkDefault ../home/.xmonad/xmonad.hs;

      home.file.".fehbg".text = ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --bg-fill --no-fehbg ~/.wallpaper
      '';

      home.file.".config/polybar/launch.sh".source = ../home/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = ../home/.config/polybar/config;
    };
  };
}
