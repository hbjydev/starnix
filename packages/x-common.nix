{ config, pkgs, lib, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  environment = {
    variables = {
      VISUAL = "nvim";
      BROWSER = "chromium";
      TERMINAL = "alacritty";
      GTK_THEME = "Ant-Dracula";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    etc."gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Ant-Dracula
        gtk-icon-theme-name=Papirus-Dark-Maia
        gtk-font-name=Roboto 16
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        application/javascript=nvim.desktop;
        application/json=nvim.desktop;
        text/plain=nvim.desktop;
        inode/directory=spacefm.desktop
        x-scheme-handler/http=chromium.desktop
        x-scheme-handler/https=chromium.desktop
        x-scheme-handler/ftp=chromium.desktop
        x-scheme-handler/chrome=chromium.desktop
        text/html=chromium.desktop
        application/x-extension-htm=chromium.desktop
        application/x-extension-html=chromium.desktop
        application/x-extension-shtml=chromium.desktop
        application/xhtml+xml=chromium.desktop
        application/x-extension-xhtml=chromium.desktop
        application/x-extension-xht=chromium.desktop
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop
        x-scheme-handler/about=chromium.desktop
        x-scheme-handler/unknown=chromium.desktop
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;
        image/png=nomacs.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/png=nomacs.desktop;imv.desktop;
        [Added Associations]
        application/javascript=nvim.desktop;
        application/json=nvim.desktop;
        text/markdown=nvim.desktop;
        text/plain=nvim.desktop;
        x-scheme-handler/http=chromium.desktop;
        x-scheme-handler/https=chromium.desktop;
        x-scheme-handler/ftp=chromium.desktop;
        x-scheme-handler/chrome=chromium.desktop;
        text/html=chromium.desktop;
        application/x-extension-htm=chromium.desktop;
        application/x-extension-html=chromium.desktop;
        application/x-extension-shtml=chromium.desktop;
        application/xhtml+xml=chromium.desktop;
        application/x-extension-xhtml=chromium.desktop;
        application/x-extension-xht=chromium.desktop;
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop;
        application/pdf=org.gnome.Evince.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/png=nomacs.desktop;imv.desktop;
        image/png=nomacs.desktop;
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;      
      '';
    };
  };

  console.useXkbConfig = true;

  services.gnome3.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs;
    [
      x11vnc # VNC Server
      tigervnc # VNC Viewer

      xxkb
      xorg.xev
      xorg.xfd
      xorg.xkbcomp
      conky
      xdotool
      seturgent
      alacritty
      xclip
      rofi
      libnotify
      dunst
      polybar
      nix-du

      glxinfo
      feh
      spotify
      mpv
      vlc

      chromium
      
      arandr

      unstable.discord
      teams
      riot-desktop

      unstable.ant-dracula-theme
    ];
}
