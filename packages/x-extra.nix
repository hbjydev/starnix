#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
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
      samba
      smbclient
      cifs-utils
    ];
}
