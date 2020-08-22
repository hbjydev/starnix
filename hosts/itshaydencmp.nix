#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
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

      #../x/xmonad.nix
      #../x/bspwm.nix
      ../x/i3.nix
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

    networking.hostName = "itshaydencmp";
    networking.firewall.enable = lib.mkForce true;
    networking.networkmanager.enable = true;
    networking.useDHCP = false;
    networking.interfaces.enp40s0.useDHCP = true;
    networking.interfaces.wlp39s0.useDHCP = true;

    boot.cleanTmpDir = true;
    boot.tmpOnTmpfs = true;
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/cd94bfbc-8b24-44a5-83d7-af9521c3fd13";
      fsType = "ext4";
    };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/8511-8521";
      fsType = "vfat";
    };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/92b0b9b7-c797-460c-b6dd-faad7040a2bd"; }
    ];

    nix.maxJobs = lib.mkDefault 12;

    hardware = {
      cpu.amd.updateMicrocode = true;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];

    i18n.inputMethod.enabled = "ibus";
    i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ anthy mozc ];
  }
