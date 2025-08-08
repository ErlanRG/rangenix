{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    historyLimit = 100000;
    keyMode = "vi";
    escapeTime = 10;
    mouse = true;
    baseIndex = 1;
    prefix = "C-space";
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          # Options to make tmux more pleasant
          set -g default-terminal "tmux-256color"

          # Configure the catppuccin plugin
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_status_style "none"
          set -g @catppuccin_pane_status_enabled "off"
          set -g @catppuccin_pane_border_status "off"

          # status left look and feel
          set -g status-left-length 100
          set -g status-left ""
          set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  #S }}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
          set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

          # status right look and feel
          set -g status-right-length 100
          set -g status-right ""
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}, none]│"
          set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %I:%M %p "

          # center
          set -g status-style "bg=#{@thm_bg}"
          set -g status-justify "absolute-centre"

          # pane border look and feel
          setw -g pane-border-status top
          setw -g pane-border-format ""
          setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
          setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
          setw -g pane-border-lines single

          # Window look and feel
          set -wg automatic-rename on
          set -g automatic-rename-format "Window"

          set -g window-status-format " #I "
          set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
          set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
          set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
          set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
          set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"

          set -g window-status-current-format " #I "
          set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"
        '';
      }
    ];

    extraConfig = ''
      # Set status bar at the top
      set -g status-position top

      # Reload config file
      unbind r
      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display-message " Config reloaded"


      ### ─────────────────────────────────────────────────────────────
      ###  SESSION MANAGEMENT
      ### ─────────────────────────────────────────────────────────────

      # Create or attach to a session
      bind S command-prompt -p " New Session:" "new-session -A -s '%%'"

      # Rename current session
      bind N command-prompt -p " Rename Session:" "rename-session '%%'"

      # Kill session with confirmation
      bind K confirm kill-session

      ### ─────────────────────────────────────────────────────────────
      ###  WINDOW MANAGEMENT
      ### ─────────────────────────────────────────────────────────────

      # Rename current window
      unbind n
      bind n command-prompt -p " Rename Window:" "rename-window '%%'"

      # Open a new window in the current working directory
      unbind w
      bind w new-window -c "#{pane_current_path}"

      # Navigate between windows using Alt + h/l
      bind -n M-h previous-window
      bind -n M-l next-window

      ### ─────────────────────────────────────────────────────────────
      ###  PANE MANAGEMENT
      ### ─────────────────────────────────────────────────────────────

      # Unbind default split keys (just to avoid conflicts)
      unbind %
      unbind '"'
      unbind v
      unbind b

      # Split panes with current path inheritance
      bind v split-window -h -c "#{pane_current_path}"  # Vertical split
      bind h split-window -v -c "#{pane_current_path}"  # Horizontal split

      # Navigate panes using Ctrl + h/j/k/l
      bind C-h select-pane -L
      bind C-j select-pane -D
      bind C-k select-pane -U
      bind C-l select-pane -R

      # Resize panes using Ctrl + Arrow keys
      bind -n C-Left  resize-pane -L 10 \; send-keys C-l
      bind -n C-Right resize-pane -R 10
      bind -n C-Up    resize-pane -U 10
      bind -n C-Down  resize-pane -D 10

      ### ─────────────────────────────────────────────────────────────
      ###  COPY MODE (VI KEYBINDINGS)
      ### ─────────────────────────────────────────────────────────────

      # Unbind default copy mode keys (optional cleanup)
      unbind -T copy-mode-vi Space
      unbind -T copy-mode-vi Enter

      # Use 'v' to start selection, 'y' to copy to system clipboard (via xsel)
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip --clipboard"

      # Enter copy mode with prefix + [
      # Exit copy mode with 'q' (default)
    '';
  };
}
