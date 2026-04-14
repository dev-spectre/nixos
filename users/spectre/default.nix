{ pkgs, inputs, ... }:

{
  imports = [
    ./hyprland
  ];

  home.username      = "spectre";
  home.homeDirectory = "/home/spectre";
  home.stateVersion  = "25.11";

  programs.home-manager.enable = true;

  # ── Packages ──────────────────────────────────────────────────────────────
  home.packages = with pkgs; [
    # Browsers & editors
    brave
    vscode

    # CLI tools
    git
    curl
    wget
    bc
    ffmpeg

    # File managers
    nautilus

    # Media
    playerctl

    # Theming — Material You pipeline
    matugen      # Generate Material You palette from wallpaper
    pywal16      # Classic pywal color generation
  ];

  # ── XDG ───────────────────────────────────────────────────────────────────
  xdg.enable = true;

  # ── Shell: fish (primary) ─────────────────────────────────────────────────
  programs.fish = {
    enable = true;
    shellAliases = {
      ll     = "ls -lah";
      ".."   = "cd ..";
      # Rebuild shortcuts
      nrs    = "sudo nixos-rebuild switch --flake ~/nixos#skynet";
      hms    = "home-manager switch --flake ~/nixos#spectre@skynet";
      update = "sudo nixos-rebuild switch --flake ~/nixos#skynet";
    };
  };

  # ── Shell: bash (fallback) ────────────────────────────────────────────────
  programs.bash = {
    enable       = true;
    shellAliases = {
      ll  = "ls -lah";
      ".." = "cd ..";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos#skynet";
      hms = "home-manager switch --flake ~/nixos#spectre@skynet";
    };
  };

  # ── Terminal ──────────────────────────────────────────────────────────────
  programs.kitty = {
    enable   = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell       = false;
    };
  };
}
