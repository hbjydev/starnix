{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      bitwarden-cli
    ];
}
