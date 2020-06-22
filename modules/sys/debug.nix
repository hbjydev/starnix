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
  systemd.service.sshd.wantedBy = lib.mkForce [];
}
