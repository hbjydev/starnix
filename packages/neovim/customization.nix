{ pkgs }:

let
  vimrc = pkgs.callPackage ./vimrc.nix {};
  plugins = pkgs.callPackage ./plugins.nix {};
in
{
  customRC = vimrc;
  vam = {
    knownPlugins = pkgs.vimPlugins // plugins;

    pluginDictionaries = [
      { name = "vim-fugitive"; }
      { name = "typescript-vim"; }
      { name = "coc-nvim"; }
      { name = "undotree"; }
      { name = "nerdtree"; }
      { name = "fzf-vim"; }
      { name = "editorconfig-vim"; }
      { name = "vim-devicons"; }
      { name = "goyo-vim"; }
      { name = "lightline-vim"; }
      { name = "vim-nix"; }

      # CoC plugins
      { name = "coc-css"; }
      { name = "coc-emmet"; }
      { name = "coc-eslint"; }
      { name = "coc-fzf"; }
      { name = "coc-git"; }
      { name = "coc-highlight"; }
      { name = "coc-html"; }
      { name = "coc-jest"; }
      { name = "coc-json"; }
      { name = "coc-pairs"; }
      { name = "coc-phpls"; }
      { name = "coc-prettier"; }
      { name = "coc-snippets"; }
      { name = "coc-spell-checker"; }
      { name = "coc-stylelint"; }
      { name = "coc-tabnine"; }
      { name = "coc-tsserver"; }
      { name = "coc-yaml"; }
      { name = "coc-yank"; }
    ];
  };
}
