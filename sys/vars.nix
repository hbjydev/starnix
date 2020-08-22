#  _   ___  __
# | |_| \ \/ / starnix -- (c) Hayden Young 2020
# |  _  |\  /  https://github.com/itshaydendev/starnix
# |_| |_|/_/   https://itshayden.dev
# 
{ config, lib, ... }:
{
  options.vars = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };
  config._module.args.vars = config.vars;
}
