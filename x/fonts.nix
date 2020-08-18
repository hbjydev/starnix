{ config, pkgs, lib, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  fonts = {
    enableDefaultFonts = false;
    enableFontDir = true;
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "ShureTechMono Nerd Font" ];
        sansSerif = [ "Roboto" ];
	      serif = [ "Roboto Slab" ];
      };
    };

    fonts = with pkgs;
      [
        terminus_font
        unifont
        noto-fonts-emoji
        corefonts

        siji

        (unstable.nerdfonts.override { fonts = [
          "Terminus"
          "ShareTechMono"
        ]; })

        unstable.inter
        open-sans
        roboto
        roboto-slab
        roboto-mono
      ];
  };

  environment.systemPackages = with pkgs; [ font-manager ];
}
