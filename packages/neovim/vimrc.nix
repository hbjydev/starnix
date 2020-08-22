#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
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
