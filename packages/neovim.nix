{ config, pkgs, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
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
            customRC = builtins.readFile ../home/.config/nvim/init.vim;
            plug.plugins = with unstable.vimPlugins; [
              awesome-vim-colorschemes
              fugitive
              typescript-vim
              undotree
              nerdtree
              vimwiki
              fzf-vim
              editorconfig-vim
              vim-devicons
              goyo-vim
              limelight-vim
              lightline-vim
              vim-nix

              coc-nvim
              coc-tsserver
              coc-tabnine
              coc-json
              coc-jest
              coc-prettier
              coc-html
              coc-eslint
              coc-emmet
              coc-css
              coc-yaml
              coc-highlight
              coc-snippets
            ];

          };
        }
      )
    ];
}
