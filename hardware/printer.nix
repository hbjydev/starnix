{ pkgs, ... }:
{
  services.printing = {
    enable = true;
  };
  services.system-config-printer.enable = true;
}
