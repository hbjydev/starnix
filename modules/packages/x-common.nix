{ config, pkgs, lib, ... }:
{
  environment = {
    variables = {
      VISUAL = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };

    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        application/javascript=nvim.desktop;
        application/json=nvim.desktop;
        text/plain=nvim.desktop;
        inode/directory=spacefm.desktop
        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        x-scheme-handler/ftp=firefox.desktop
        x-scheme-handler/chrome=firefox.desktop
        text/html=firefox.desktop
        application/x-extension-htm=firefox.desktop
        application/x-extension-html=firefox.desktop
        application/x-extension-shtml=firefox.desktop
        application/xhtml+xml=firefox.desktop
        application/x-extension-xhtml=firefox.desktop
        application/x-extension-xht=firefox.desktop
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop
        x-scheme-handler/about=firefox.desktop
        x-scheme-handler/unknown=firefox.desktop
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
        x-scheme-handler/http=firefox.desktop;
        x-scheme-handler/https=firefox.desktop;
        x-scheme-handler/ftp=firefox.desktop;
        x-scheme-handler/chrome=firefox.desktop;
        text/html=firefox.desktop;
        application/x-extension-htm=firefox.desktop;
        application/x-extension-html=firefox.desktop;
        application/x-extension-shtml=firefox.desktop;
        application/xhtml+xml=firefox.desktop;
        application/x-extension-xhtml=firefox.desktop;
        application/x-extension-xht=firefox.desktop;
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

  environment.systemPackages = with pkgs;
    [
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
      nix-du

      glxinfo
      feh
      spotify
      mpv
      vlc
      
      arandr

      discord
      teams
      riot-desktop
    ];
}
