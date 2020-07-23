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
    displayManager = {
      defaultSession = lib.mkDefault "none+bspwm";
    };

    windowManager.bspwm = {
      enable = true;
      configFile = ../../home/.config/bspwm/bspwmrc;
      sxhkd.configFile = ../../home/.config/sxhkd/sxhkdrc;
    };
  };
  
  home-manager = {
    users.${vars.user} = {
      xsession.windowManager.bspwm = {
        enable = true;

        settings = {
          "border_width" = 2;
          "split_ratio" = 0.55;

          "top_padding" = 0;
          "bottom_padding" = 0;
          "left_padding" = 0;
          "right_padding" = 0;

          "window_gap" = 0;

          "borderless_monocle" = true;
          "gapless_monocle" = true;

          "normal_border_color" = "#5c6370";
          "active_border_color" = "#9c71c7";
          "focused_border_color" = "#9c71c7";
          "presel_feedback_color" = "#e5c07b";
        };

        monitors = {
         "DisplayPort-0" = [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X" ];
        };

        rules = {
          "feh" = {
            state = "floating";
          };

          "Pavucontrol" = {
            center = true;
          };

          "Chromium:crx_baipgmmeifmofkcilhccccoipmjccehn" = {
            state = "floating";
          };

          "Microsoft Teams - Preview" = {
            state = "floating";
            desktop = "^10";
          };
        };

        startupPrograms = [
          "dunst"
          "xsetroot -cursor_name left_ptr"
          "sh /home/${vars.user}/.config/polybar/launch.sh"
          "sh /home/${vars.user}/.fehbg"
        ];
      };

      home.file.".fehbg".text = ''
        #!/bin/sh
        /run/current-system/sw/bin/feh --bg-fill --no-fehbg ~/.wallpaper
      '';

      home.file.".config/polybar/launch.sh".source = ../../home/.config/polybar/launch.sh;
      home.file.".config/polybar/config".source = ../../home/.config/polybar/config;
    };
  };

}
