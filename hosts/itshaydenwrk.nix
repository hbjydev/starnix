{ config, lib, pkgs, ... }:
{
  system.stateVersion = "20.09";

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

      ../hardware/sound.nix
      ../hardware/printer.nix

      ../x/xmonad.nix
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
      
      ../net/firewall-desktop.nix
      ../net/sshd.nix

      ../vm/docker.nix
      ../vm/hypervisor.nix
      ../packages/kube.nix
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
