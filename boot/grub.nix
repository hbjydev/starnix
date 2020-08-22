#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ lib, pkgs, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      version = 2;
      backgroundColor = "#21202D";
      memtest86.enable = true;
      configurationLimit = 30;

      extraConfig = ''
        set menu_color_normal=light-blue/black
	set menu_color_highlight=black/light-blue
      '';
      splashMode = "normal";
      splashImage = null;
    };
  };

  environment.systemPackages = with pkgs; [ memtest86plus ];
}
