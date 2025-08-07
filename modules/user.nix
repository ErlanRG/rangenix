{ config, host, pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "Erlan Rangel";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    packages = with pkgs; [ ];
  };

  nix.settings.allowed-users = [ "${username}" ];
}
