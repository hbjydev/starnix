# starnix

My personal [NixOS](https://nixos.org) configuration.

## Setup

To set this up, follow the quick 3-step process:

```shell
root $ git clone https://github.com/itshaydendev/starnix.git /etc/nixos
root $ ln -sf /etc/nixos/hosts/<a-config-file>.nix /etc/nixos/configuration.nix

# If you've not installed yet
root $ nixos-install

# If you've already installed, but are switching to this config
root $ nixos-rebuild switch --keep-going --install-bootloader
```

## Updating

There's a shell script built in to the config called `hd-sync`. Run it and it'll
download & rebuild the latest changes from the git repo.

## Acknowledgements

- [Idempotent Desktop](https://github.com/ksevelyar/idempotent-desktop) for
  showing me 'the way' and introducing me to NixOS, and for inspiring 90% of
  the layout of this repository.
- [Robert Helgesson](https://github.com/rycee) for making
  [home-manager](https://github.com/rycee/home-manager), which allows me to do a
  lot of personal filesystem-related stuff easily, as well as making app configs
  easier!
- [NixOS](https://nixos.org) for existing and allowing me to have this awesome,
  reproducible setup on all of my computers. It makes my life a hell of a lot
  easier when I need to reinstall or bootstrap a new PC.

---

```
  _   ___  __
 | |_| \ \/ / starnix -- (c) Hayden Young 2020
 |  _  |\  /  https://github.com/itshaydendev/starnix
 |_| |_|/_/   https://itshayden.dev 

```

