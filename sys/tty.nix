#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ pkgs, ... }:
{
  services.mingetty.greetingLine = ''\l'';

  console = {
    earlySetup = true;

    # Joker palette
    colors = [
      "1b161f"
      "ff5555"
      "54c6b5"
      "d5aa2a"
      "bd93f9"
      "ff79c6"
      "8be9fd"
      "bfbfbf"

      "1b161f"
      "ff6e67"
      "5af78e"
      "ffce50"
      "caa9fa"
      "ff92d0"
      "9aedfe"
      "e6e6e6"
    ];
  };
}
