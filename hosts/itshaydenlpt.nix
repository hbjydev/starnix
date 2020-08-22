#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, lib, pkgs, ... }:
{
  system.stateVersion = "20.03";

  imports =
    [
      <nixpkgs/nix../installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/hayden.nix

      ../sys/aliases.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/vars.nix

      ../boot/grub.nix

      ../services/common.nix
      ../services/avahi.nix
      ../services/keybase.nix
      ../services/x.nix

      ../x/gnome3.nix
      ../x/bspwm.nix
      ../x/xmonad.nix
      ../x/fonts.nix
      ../packages/x-common.nix
      ../packages/x-extra.nix

      ../packages/nonfree.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/neovim.nix
      ../packages/firefox.nix
      ../packages/gnupg.nix
      ../packages/pass.nix

      ../hardware/sound.nix
      ../hardware/printer.nix
      ../hardware/power-management.nix

      ../net/firewall-desktop.nix
      ../net/sshd.nix

      ../vm/docker.nix
      ../vm/hypervisor.nix
    ];

    boot.loader.grub.backgroundColor = lib.mkForce "#09090B";
    boot.plymouth.enable = true;

    networking.hostName = "itshaydenlpt";
    networking.firewall.enable = lib.mkForce true;
    networking.networkmanager.enable = true;
    networking.useDHCP = false;
    networking.interfaces.eno1.useDHCP = true;
    networking.interfaces.wlp2s0.useDHCP = true;

    boot.cleanTmpDir = true;
    boot.tmpOnTmpfs = true;
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [];

    fileSystems."/" =
      {
        device = "/dev/disk/by-uuid/c86ecf53-27b7-47f8-ae5e-e7b12826c071";
	fsType = "ext4";
      };

    fileSystems."/home" =
      {
        device = "/dev/disk/by-uuid/b075c568-0820-4b10-bfc4-b88532c3fe1f";
	fsType = "ext4";
      };

    fileSystems."/boot" =
      {
        device = "/dev/disk/by-uuid/D4D9-3FA1";
	fsType = "vfat";
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/aae36741-48ca-4ac7-9b0e-62e0614c9ed5"; }
      ];

    hardware = {
      cpu.intel.updateMicrocode = true;
    };
    services.xserver.videoDrivers = [ "intel" ];
}
