#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{
  environment.shellAliases = {
    s = "sudo";
    
    log = "sudo journalctl --output cat -u";
    log-previous-boot = "sudo journalctl --boot=-1";

    da = "composer dumpautoload";

    ports = "sudo lsof -Pni";
    pgrep = "pgrep --full";
    pkill = "pkill --full";
    l = "ls -lahXF --group-directories-first";
    v = "nvim";
    vo = "nvim -o (fzf)";
    vv = "nvim -U none";
    r = "rsync -ra --info=progress2";
    ns = "notify-send";

    g = "git";

    ga = "git add";
    gau = "git add -u";

    gco = "git checkout";
    gc = "git commit --message";
    gca = "git commit --all --message";

    gs = "git status --short";
    gd = "git diff";
    gdc = "git diff --cached";
    gfr = "git pull --rebase";
    gp = "git push";
    gso = "git log -p --all --source -S ";
    
    fd = "fd --hidden --exclude .git";
    off = "sleep 0.5 && xset dpms force off; pkill -f spotify; xdotool key XF86AudioPause";

    grab-display = "export DISPLAY = ':0.0'";

    e = "sudo nvim /etc/nixos/configuration.nix";
    refresh = "hd-refresh-channels";
    b = "sudo nixos-rebuild switch --keep-going";
    br = "b && xmonad --restart";
    bu = "refresh && b";
    no = "nixos-option";
    hd-wipe-user-packages = "nix-env -e '*'";

    hd-gc = "sudo nix-collect-garbage --delete-older-than 30d";
    hd-inspect-store = "nix path-info -rSh /run/current-system | sort -k2h ";
    hd-sync = "cd /etc/nixos && git stash && git pull --rebase";

    ssh = "TERM=xterm-256color ssh";
  };
}
