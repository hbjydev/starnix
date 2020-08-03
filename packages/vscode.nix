{ config, lib, pkgs, vars, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      programs.vscode.enable = true;

      programs.vscode.package = unstable.vscode;

      programs.vscode.userSettings = {
        "editor.tabSize" = 2;
        "editor.lineNumbers" = "relative";
        "[php]"."editor.tabSize" = 4;
        "workbench.colorTheme" = "GitHub Dark";
      };

      programs.vscode.extensions = with pkgs.vscode-extensions; [
        ms-vscode-remote.remote-ssh
        ms-azuretools.vscode-docker
        redhat.vscode-yaml
        vscodevim.vim
      ];
    };
  };
}
