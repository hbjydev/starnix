{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      fzf
      ripgrep
      universal-ctags
      global
      python3

      (
        neovim.override {
          vimAlias = true;
	  viAlias = true;
	  configure = {
            customRC = builtins.readFile ../../home/.config/nvim/init.vim;
	  };
	}
      )
    ];
}
