#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, pkgs, vars, ... }:
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  nixpkgs.overlays = import ../overlays;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  users.users.${vars.user} = {
    uid = 1000;
    isNormalUser = true;

    extraGroups = [ "wheel" "networkmanager" "libvirtd" "nginx" ];
  };

  systemd.services."home-manager-ugly-hack" = {
    script = "mkdir -p /nix/var/nix/profiles/per-user/${vars.user} && chown ${vars.user}:users /nix/var/nix/profiles/per-user/${vars.user}";
    path = [ pkgs.coreutils ];
    before = [ "home-manager-${vars.user}.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  location.latitude = 53.32;
  location.longitude = -1.34;

  users.defaultUserShell = pkgs.bash;
  i18n.defaultLocale = "en_GB.UTF-8";

  time.timeZone = "Europe/London";
  
  environment = {
    variables = {
      EDITOR = "nvim";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      programs.git = {
        enable = true;
        extraConfig = {
          "push" = { default = "current"; };
          "rerere" = { enabled = 1; };
          "core" = {
            excludesfile = "~/.gitignore";
            pager = ''
              delta --plus-color="#16271C" --minus-color="#331F21" --theme='ansi-dark'
            '';
          };
          "interactive" = {
            diffFilter = "delta --color-only";
          };
        };

        aliases = {
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(magenta)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an%>%Creset' --abbrev-commit";
          pp = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
          recent-branches = "branch --sort=-committerdate";
        };
      };

      home.file.".icons/default/index.theme".text = ''
        [Icon Theme]
        Name=Default
        Comment=Default Cursor Theme
        Inherits=Vanilla-DMZ
      '';

      home.file.".config/alacritty/alacritty.yml".source = ../home/.config/alacritty/alacritty.yml;
      home.file.".config/rofi/config.rasi".source = ../home/.config/rofi/config.rasi;
      home.file.".config/rofi/theme.rasi".source = ../home/.config/rofi/theme.rasi;
      home.file.".config/dunstrc".source = ../home/.config/dunstrc;
      home.file.".config/polybar/config".source = ../home/.config/polybar/config;
      home.file.".config/polybar/launch.sh".source = ../home/.config/polybar/launch.sh;
      home.file.".fehbg".source = ../home/.fehbg;
      home.file.".config/nvim/colors/starlight.vim".source = ../packages/neovim/vimrc/colorschemes/starlight.vim;
      home.file.".config/nvim/colors/harsh.vim".source = ../packages/neovim/vimrc/colorschemes/harsh.vim;
      home.file.".local/share/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/starlight.vim".source = ../home/.local/share/nvim/plugged/lightline.vim/autoload/lightline/colorscheme/starlight.vim;
    };
  };
}
