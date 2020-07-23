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
      ../modules/packages/kube.nix
    ];

    boot.loader.grub.backgroundColor = lib.mkForce "#161c1f";
    boot.plymouth.enable = true;

    networking.hostName = "itshaydenwrk";
    networking.firewall.enable = lib.mkForce true;
    networking.networkmanager.enable = true;
    networking.useDHCP = false;
    networking.interfaces.enp1s0.useDHCP = true;

    boot.cleanTmpDir = true;
    boot.tmpOnTmpfs = true;
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" "rtsx_usb_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/150e3f52-5dfc-4d0a-8906-71b6ce1f099f";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/9EFA-4617";
        fsType = "vfat";
      };

    swapDevices = [ ];

    nix.maxJobs = lib.mkDefault 4;
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

    hardware = {
      cpu.intel.updateMicrocode = true;
    };
#    services.xserver.videoDrivers = [ "amdgpu" ];
}
