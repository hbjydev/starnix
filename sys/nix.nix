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
