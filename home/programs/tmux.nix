{ pkgs, ... }: {
  # TMUX
  programs.tmux = {
    enable = true;
    mouse = true;
    # shortcut = "a";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      pain-control
      yank
      prefix-highlight
      better-mouse-mode

      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'off'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      bind-key ` last-window
      bind-key e send-prefix
      set -g status-position bottom
      set -g status-bg colour234
      set -g status-fg colour137
      set -g status-left ""
      set -g status-right '#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
      set -g status-right-length 50
      set -g status-left-length 20
      setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
      setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

      # vim key to switch window and session
      bind -r j previous-window
      bind -r k next-window
      bind -r h switch-client -p
      bind -r l switch-client -n

      # vim key to move pane
      bind -r K select-pane -U
      bind -r J select-pane -D
      bind -r H select-pane -R
      bind -r L select-pane -L

      # resize pane
      bind -r C-k resize-pane -U 5
      bind -r C-j resize-pane -D 5
      bind -r C-h resize-pane -L 5
      bind -r C-l resize-pane -R 5

      # Setting yank
      set -g @yank_highlight 'true'
      set -g @yank_highlight_cursor 'true'
    '';
    prefix = "`";
    keyMode = "vi";
    historyLimit = 10000;
    baseIndex = 1;
    escapeTime = 1;
  };


}
