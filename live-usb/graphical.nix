{ config, pkgs, lib, vars, ... }:
{

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./iso.nix

    ../users/shared.nix
    ../users/live-usb.nix

    ../modules/sys/aliases.nix
    ../modules/sys/scripts.nix
    ../modules/sys/tty.nix
    ../modules/sys/debug.nix
    ../modules/sys/vars.nix
    ../modules/sys/sysctl.nix

    ../modules/services/common.nix
    ../modules/services/x.nix

    ../modules/x/xmonad.nix
    ../modules/x/fonts.nix
    ../modules/packages/x-common.nix
    # ../modules/packages/x-extra.nix

    ../modules/packages/nonfree.nix
    ../modules/packages/common.nix
    ../modules/packages/neovim.nix
    ../modules/packages/firefox.nix
    ../modules/packages/pass.nix

    ../modules/hardware/sound.nix
    ../modules/hardware/power-management.nix

    ../modules/net/firewall-desktop.nix
    ../modules/net/sshd.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub_big.png;
  isoImage.volumeID = lib.mkForce "hd-live";
  isoImage.isoName = lib.mkForce "hd-live.iso";
}
