{ stdenv, writeText }:

let
  coc = builtins.readFile ./plugins/coc.vim;
  fzf = builtins.readFile ./plugins/fzf.vim;
  lightline = builtins.readFile ./plugins/fzf.vim;
  mkdx = builtins.readFile ./plugins/mkdx.vim;
  nerdtree = builtins.readFile ./plugins/nerdtree.vim;
  undotree = builtins.readFile ./plugins/undotree.vim;
in

''
  ${coc}
  ${fzf}
  ${lightline}
  ${mkdx}
  ${nerdtree}
  ${undotree}
''
