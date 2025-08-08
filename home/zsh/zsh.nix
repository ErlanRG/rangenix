{ config, pkgs, lib, host, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" "pattern" "regexp" "root" "line" ];
      };

      history = {
        append = true;
        extended = true;
        findNoDups = true;
        ignoreDups = true;
        ignoreSpace = true;
        saveNoDups = true;
        share = true;
        size = 10000000;
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "vi-mode" ];
      };

      shellAliases = {
        # zsh config
        sz = "source $HOME/.zshrc";
        zshc = "nvim ~/.zshrc";

        # ls
        l =
          "eza -lahF --color=always --icons --git --sort=size --group-directories-first -s=Name";
        ll = "eza -lah";
        ls =
          "eza -lhF --color=always --icons --sort=size --group-directories-first";

        # git
        lg = "lazygit";

        # NixOS (flakes)
        update = "nix flake update";
        rebuild = "sudo nixos-rebuild switch --flake ~/rangenix#${host}";
        gc = "sudo nix-collect-garbage -d";
        gc-all =
          "sudo nix-collect-garbage -d && nix-collect-garbage -d"; # usuario + system cleanup
        clear_gens =
          "sudo nix-env --delete-generations +3"; # keep latest 3 gens

        # confirm before overwriting something
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";

        # other
        c = "clear";
        rmdir = "rm -rf";
        shutdown = "shutdown now";
        startup_nvim =
          "nvim --startuptime startup.log -c exit && tail -100 startup.log";

        # Tmux
        tconf = "nvim ${config.xdg.configHome}/tmux/tmux.conf";
        tk = "tmux kill-server";
        tks = "tmux kill-session -a"; # kill all sessions but the current;
        tls = "tmux list-sessions";
      };
      #TODO: find a way to include the functions to zsh without a mess.
    };

    fzf = { enable = true; };
    zoxide = { enable = true; };
  };
}
