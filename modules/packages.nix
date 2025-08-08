{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    zsh = { enable = true; };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    eza
    findutils
    firefox
    git
    keepassxc
    lazygit
    librewolf
    xdg-user-dirs
  ];
}
