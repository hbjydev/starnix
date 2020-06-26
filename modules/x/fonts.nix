{ pkgs, lib, ... }:
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
        monospace = [ "TerminessTTF Nerd Font Mono" ];
	      sansSerif = [ "Inter" ];
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

        (nerdfonts.override { fonts = [
          "Terminus"
        ]; })

        inter
        open-sans
        roboto
        roboto-slab
        roboto-mono
      ];
  };

  environment.systemPackages = with pkgs; [ font-manager ];
}
