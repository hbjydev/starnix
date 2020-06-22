{ config, pkgs, vars, ... }:
{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

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
    };
  };
}
