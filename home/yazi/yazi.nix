{ config, lib, ... }:

{
  programs.yazi = {
    enable = true;
    settings = lib.importTOML ./yazi.toml;
    keymap = lib.importTOML ./keymap.toml;
    theme = lib.importTOML ./theme.toml;
  };
}
