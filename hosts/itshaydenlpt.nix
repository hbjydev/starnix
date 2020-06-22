{ config, lib, pkgs, ... }:
{
  system.stateVersion = "20.03";

  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/hayden.nix

      ../modules/sys/aliases.nix
      ../modules/sys/nix.nix
      ../modules/sys/scripts.nix
      ../modules/sys/sysctl.nix
      ../modules/sys/tty.nix
      ../modules/sys/vars.nix

      ../modules/boot/grub.nix

      ../modules/services/common.nix
      ../modules/services/x.nix

      ../modules/x/gnome3.nix
      ../modules/x/fonts.nix
      ../modules/packages/x-common.nix
      ../modules/packages/x-extra.nix

      ../modules/packages/nonfree.nix
      ../modules/packages/common.nix
      ../modules/packages/dev.nix
      ../modules/packages/neovim.nix
      ../modules/packages/firefox.nix

      ../modules/hardware/sound.nix

      ../modules/net/firewall-desktop.nix
      ../modules/net/sshd.nix

      ../modules/vm/docker.nix
      ../modules/vm/hypervisor.nix
    ];

    boot.loader.grub.backgroundColor = lib.mkForce "#09090B";

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
