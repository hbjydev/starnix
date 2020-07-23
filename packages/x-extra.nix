{ config, pkgs, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs;
    [
      # office
      libreoffice-fresh
      unstable.thunderbird-bin
      qalculate-gtk

      # media
      ffmpeg
      flameshot

      # dev
      asciinema

      # irc
      weechat

      # util
      qt4
      kdeconnect
    ];
}
