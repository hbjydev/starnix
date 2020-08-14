{ stdenv, writeText }:

let
  general = builtins.readFile ./vimrc/general.vim;
  mappings = builtins.readFile ./vimrc/mappings.vim;
  color = builtins.readFile ./vimrc/color.vim;

  plug = import ./vimrc/plugins.nix { inherit stdenv writeText; };
in

''
  ${general}
  ${mappings}
  ${color}

  ${plug}
''
