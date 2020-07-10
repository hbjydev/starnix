{ config, lib, pkgs, ... }:
{
  system.stateVersion = "20.09";

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
      ../modules/services/avahi.nix
      ../modules/services/keybase.nix
      ../modules/services/x.nix

      ../modules/hardware/sound.nix
      ../modules/hardware/printer.nix

      ../modules/x/xmonad.nix
      ../modules/x/gnome3.nix
      ../modules/x/fonts.nix
      ../modules/packages/x-common.nix
      ../modules/packages/x-extra.nix

      ../modules/packages/nonfree.nix
      ../modules/packages/common.nix
      ../modules/packages/dev.nix
      ../modules/packages/neovim.nix
      ../modules/packages/firefox.nix
      ../modules/packages/gnupg.nix
      ../modules/packages/pass.nix
      
      ../modules/net/firewall-desktop.nix
      ../modules/net/sshd.nix

      ../modules/vm/docker.nix
      ../modules/vm/hypervisor.nix
    ];

    boot.loader.grub.backgroundColor = lib.mkForce "#161c1f";
    boot.plymouth.enable = true;

    networking.hostName = "itshaydencmp";
    networking.firewall.enable = lib.mkForce true;
    networking.networkmanager.enable = true;
    networking.useDHCP = false;
    networking.interfaces.enp5s0.useDHCP = true;
    networking.interfaces.wlp6s0.useDHCP = true;

    boot.cleanTmpDir = true;
    boot.tmpOnTmpfs = true;
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/e17bd8dc-cf59-4cf9-a1ec-34aa3272aabc";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/5A22-E97D";
        fsType = "vfat";
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/7b3bbc83-ea9f-4c48-ba03-ad76eee93c0f"; }
      ];

    nix.maxJobs = lib.mkDefault 12;

    hardware = {
      cpu.amd.updateMicrocode = true;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];
}
