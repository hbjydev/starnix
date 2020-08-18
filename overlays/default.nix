let
  toplevel = {
    pkgs = (import ./pkgs.nix);
  };
in
  with toplevel; [
    pkgs
  ]
