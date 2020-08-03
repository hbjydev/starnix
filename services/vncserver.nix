{ pkgs, vars, lib, config, ... }:

let
  cfg = config.services.vncServer;
in

with lib;

{
  options = {
    services.vncServer = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Start a VNC server for a user.";
      };

      user = mkOption {
        default = "${vars.user}";
        type = with types; uniq string;
        description = "The user to create a VNC server for.";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.vncServer = {
      description = "VNC Server";
      after = [ "network.target" ];
      serviceConfig = {
        Type = "forking";
        User = "${vars.user}";
        ExecStart = ''${pkgs.tigervnc}/bin/vncserver :1 -geometry 1920x1080 -depth 24'';
        ExecStop = ''${pkgs.procps}/bin/pkill --full vncserver'';
      };
    };

    environment.systemPackages = [ pkgs.tigervnc pkgs.procps ];
  };
}
