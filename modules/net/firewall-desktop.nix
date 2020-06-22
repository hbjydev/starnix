{ lib, ... }:
{
  systemd.services.sshd.wantedBy = lib.mkForce [];

  networking.firewall.enable = lib.mkForce true;
  networking.firewall.allowedTCPPorts = [
    # Dev
    3000
    4000
    8080
    4040
    8000
  ];
  networking.firewall.allowedUDPPorts = [];
}
