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
