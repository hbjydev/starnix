{ pkgs, lib, config, ... }:

{
  programs.chromium = {
    enable = true;

    homepageLocation = "https://itshayden.dev";

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      "bmnlcjabgnpnenekpadlanbbkooimhnj" # honey
      "hepbieccgbieoeaigepkojmogpkjfpin" # pip everywhere

      "kljmejbpilkadikecejccebmccagifhl" # saucenao
    ];

    extraOpts = {
      "PasswordManagerEnabled" = false;
    };
  };

  environment.systemPackages = [ pkgs.chromium ];
}
