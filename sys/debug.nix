#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ lib, ... }:
{
  boot.plymouth.enable = lib.mkForce false;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = lib.mkForce false;
  };
  services.openssh = {
    enable = lib.mkForce true;
    permitRootLogin = lib.mkForce "yes";
    passwordAuthentication = lib.mkForce true;
  };
}
