#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ vars, pkgs, lib, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = lib.mkDefault false;
  };

  users.users.${vars.user}.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
