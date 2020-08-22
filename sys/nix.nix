#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{
  nix = {
    useSandbox = true;

    daemonNiceLevel = 2;
    daemonIONiceLevel = 2;

    extraOptions = ''
      connect-timeout = 5
      min-free = ${toString (10 * 1024 * 1024 * 1024)}
      max-free = ${toString (20 * 1024 * 1024 * 1024)}
    '';
  };
}
