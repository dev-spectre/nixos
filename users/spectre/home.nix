{ config, pkgs, ... }:

{
  home.username = "spectre";
  home.homeDirectory = "/home/spectre";

  home.packages = with pkgs; [
    # Web & Dev
    vivaldi
    vscode
    git
    curl
    wget

    # File Management
    nautilus
  ];

  # 1. Terminal & Shell
  programs.kitty.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/nixos#skynet";
    };
    loginShellInit = ''
      if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec hyprland
      end
    '';
  };

  # 2. Hyprland Configuration via Home Manager
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      "$mod" = "SUPER";
      
      # Auto-start your custom shell here when you install it
      exec-once = [
        # "your-shell-command &" 
      ];

      # Monitor config (auto-detects resolution and refresh rate)
      monitor = ",preferred,auto,1";

      # Basic Keybinds
      bind = [
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"

        # Focus Movement (Arrow Keys)
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"

        # Move windows to workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
      ];
      
      # Window rules (example: remove tearing for games)
      windowrulev2 = "suppressevent maximize, class:.*"; 
    };
  };

  home.stateVersion = "25.11";
}
