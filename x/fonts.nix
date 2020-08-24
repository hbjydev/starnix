#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
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
        monospace = [ "Terminus" "Roboto Mono" ];
        sansSerif = [ "Roboto" ];
	      serif = [ "Roboto Slab" ];
      };
    };

    fonts = with pkgs;
      [
        unstable.terminus_font.otb
        unstable.terminus_font_ttf
        noto-fonts-emoji
        corefonts

        siji.otb

#        (unstable.nerdfonts.override { fonts = [
#          "Terminus"
#          "ShareTechMono"
#        ]; })

        unstable.inter
        open-sans
        roboto
        roboto-slab
        roboto-mono
      ];
  };

  environment.systemPackages = with pkgs; [ font-manager ];
}
