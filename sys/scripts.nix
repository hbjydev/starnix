{ pkgs, ... }:

let
  hd-error = pkgs.writeScriptBin "hd-error" ''
    #!${pkgs.stdenv.shell}
    echo -e "\n💀\n"
  '';

  hd-refresh-channels = pkgs.writeScriptBin "hd-refresh-channels" ''
    #!${pkgs.stdenv.shell}
    set -e

    sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable 
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos 
    
    for i in {1..5}; do sudo nix-channel --update && break || id-error; done
    
    sudo nix-channel --list
  '';

  hd-build-iso = pkgs.writeScriptBin "hd-build-iso" ''
    #!${pkgs.stdenv.shell}
    set -e

    nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb/graphical.nix --no-out-link
  '';

  hd-build-rpi = pkgs.writeScriptBin "hd-build-rpi" ''
    #!${pkgs.stdenv.shell}
    set -e

    sudo nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=/etc/nixos/live-usb/rpi.nix --no-out-link --system aarch64-linux
  '';

  hd-install = pkgs.writeScriptBin "hd-install" ''
    #!${pkgs.stdenv.shell}
    set -e
    echo -e "\n🤖\n"
    
    hd-refresh-channels

    sudo mount /dev/disk/by-label/nixos /mnt
    sudo mkdir -p /mnt/boot
    sudo mount /dev/disk/by-label/boot /mnt/boot/
    echo -e "\n💾"
    lsblk -f
    
    echo
    sudo git clone https://github.com/itshaydendev/setup.git /mnt/etc/nixos
    sudo chown -R 1000:1000 /etc/nixos/
    
    if [ -z "$1" ]
      then
        nixos-generate-config --root /mnt
        bat /mnt/etc/nixos/*.nix
      else
        cd /mnt/etc/nixos && ln -s hosts/$1 configuration.nix
    fi
    sudo ls -lah /etc/nixos/configuration.nix
    sudo nixos-install
    echo -e "\n🍈\n"
  '';
in
{
  environment.systemPackages = [
    hd-refresh-channels
    hd-error
    hd-install

    hd-build-iso
    hd-build-rpi
  ];
}
