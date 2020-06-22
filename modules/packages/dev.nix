{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      nodejs-12_x
      php73
      go
      gcc
      insomnia # api testing
    ];
}
