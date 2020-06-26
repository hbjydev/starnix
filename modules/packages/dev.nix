{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # NodeJS
      nodejs-12_x
      
      # PHP
      php73
      php73Packages.composer

      # Golang
      go
      gcc

      # Misc.
      insomnia # api testing
      mkcert # SSL cert generation
    ];
}
