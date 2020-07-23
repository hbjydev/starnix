{ config, lib, pkgs, ... }:
{
  system.stateVersion = "20.09";

  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

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

      ../hardware/sound.nix
      ../hardware/printer.nix

      ../x/xmonad.nix
#      ../x/bspwm.nix
      ../x/gnome3.nix
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
      ../packages/vscode.nix
      
      ../net/firewall-desktop.nix
      ../net/sshd.nix

      ../vm/docker.nix
      ../vm/hypervisor.nix
      ../packages/kube.nix
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
