{ config, pkgs, lib, vars, ... }:
{

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./iso.nix

    ../users/shared.nix
    ../users/live-usb.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/vars.nix
    ../sys/sysctl.nix

    ../services/common.nix
    ../services/x.nix

    ../x/xmonad.nix
    ../x/fonts.nix
    ../packages/x-common.nix
    # ../packages/x-extra.nix

    ../packages/nonfree.nix
    ../packages/common.nix
    ../packages/neovim.nix
    ../packages/firefox.nix
    ../packages/pass.nix

    ../hardware/sound.nix
    ../hardware/power-management.nix

    ../net/firewall-desktop.nix
    ../net/sshd.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub_big.png;
  isoImage.volumeID = lib.mkForce "hd-live";
  isoImage.isoName = lib.mkForce "hd-live.iso";
}
