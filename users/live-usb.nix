# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
{ config, pkgs, lib, vars, ... }:
{
  vars.user = "neo";
  vars.email = "";
  vars.name = "Neo";

  users.users.root = {
    # id
    # To generate hashed password run mkpasswd -m sha-512
    initialHashedPassword = lib.mkForce "$6$zKk1qNy.84$mVGFT2YYt39K2NI17T7skDyyVXf8LVMG.7vF.JMrKqTq6INet9eLj8BUeLR.QAKdU2cyGELQ04UP6GFIG4LX./";
  };

  home-manager = {
    users.${vars.user} = {
      home.file.".wallpaper".source = ../assets/wallpapers/53309.jpg;
    };
  };

  users.users.${vars.user} = {
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  services.mingetty.autologinUser = lib.mkForce vars.user;
  services.mingetty.greetingLine = lib.mkForce ''\l'';
}
