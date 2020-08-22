#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/15 * * * * hayden $(which bugwarrior-pull)"
      "0 1 * * * root hd-gc"
    ];
  };
}
