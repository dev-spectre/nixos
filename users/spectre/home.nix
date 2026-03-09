{ config, pkgs, ... }:

{
  imports = [
    ./hyprland
  ];

  home.username = "spectre";
  home.homeDirectory = "/home/spectre";

  home.packages = with pkgs; [
    brave
    vscode
    git
    curl
    wget
    nautilus
    playerctl
    bc
    ffmpeg
  ];

  xdg.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
       bind = [
        "$mod, Retrun, exec, kitty"
        "$mod, M, exit"
       ];
   };
  };
  # Screen recorder ambxst fix
#  programs.gpu-screen-recorder.enable = true;

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

  home.stateVersion = "25.11";
}
