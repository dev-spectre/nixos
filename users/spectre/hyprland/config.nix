{ ... }:

{
  imports = [
    ./env.nix
    ./execs.nix
    ./animations.nix
    ./general.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    
    # Inject your massive complex rules raw so you don't have to rewrite them
    extraConfig = ''
      ${builtins.readFile ./rules.conf}
      ${builtins.readFile ./colors.conf}
    '';
  };
}
