#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ pkgs, lib, ... }:
{
  services.ratbagd.enable = true;
  services.udisks2.enable = true;
  services.greenclip.enable = true;

  services.redshift = {
    enable = true;
    temperature.night = 4000;
    temperature.day = 6500;
  };

  services.picom = {
    enable = lib.mkDefault true;
    fade = lib.mkDefault true;
    fadeDelta = lib.mkDefault 5;
    shadow = lib.mkDefault false;
    backend = lib.mkDefault "glx";
    vSync = true;
  };

  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      accelProfile = "flat";
      naturalScrolling = false;
      disableWhileTyping = true;
      clickMethod = "buttonareas";
      scrollMethod = lib.mkDefault "edge";
    };

    config = ''
      Section "InputClass"
        Identifier "Mouse"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "adaptive"
      EndSection
    '';

    serverFlagsSection = ''
      Option "BlankTime" "120"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';

    displayManager.gdm = {
      enable = true;
    };

    layout = "gb";
    desktopManager = {
      xterm.enable = false;
    };
  };
}
