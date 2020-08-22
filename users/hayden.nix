#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, pkgs, vars, lib, ... }:
{
  vars.user = "hayden";
  users.users.${vars.user} = {
    description = "Hayden Young";
  };

  networking.extraHosts =
    ''
      127.0.0.1 dev.lcl
      127.0.0.1 intranet.dev
    '';

  systemd.tmpfiles.rules =
    [
      "d /vvv 0700 1000 wheel" # secrets
      "d /c 0744 1000 wheel" # code
    ];

  home-manager = {
    users.${vars.user} = {
      programs.git = {
        userName = "Hayden Young";
        userEmail = "hayden@itshayden.dev";
      };

      home.file.".wallpaper".source = ../assets/wallpapers/tenx.jpg;
    };
  };
}
