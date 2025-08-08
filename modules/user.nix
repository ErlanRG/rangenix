{ config, host, pkgs, username, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = [ ../home ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };
    };
  };

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "Erlan Rangel";
    hashedPassword =
      "$6$pV7uf3Nj9Lak7wej$JB07ehAG8OMLy/EWemArC4jaypvhPmUDoDcGWbC4xkN3KeDlXhoxPNUCfavlNVizeUMQjFz8j41YNAQbqw4n31";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzET/47JffxKpmykjEhjeDh+7eIx0IkBiZA+hB3JxTP erlanrangel"
    ];
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    packages = with pkgs; [ ];
  };

  nix.settings.allowed-users = [ "${username}" ];
}
