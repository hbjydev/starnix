#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ lib, ... }:
{
  systemd.services.sshd.wantedBy = lib.mkForce [];

  networking.firewall.enable = lib.mkForce true;
  networking.firewall.allowedTCPPorts = [
    # HTTP(s)
    80 443

    # MySQL
    3306

    # Remote Access
    22 5901

    # Dev
    3000
    4000
    8080
    4040
    8000
  ];
  networking.firewall.allowedUDPPorts = [];

  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];
}
