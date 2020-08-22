#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ lib, ... }:
{
  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
}
