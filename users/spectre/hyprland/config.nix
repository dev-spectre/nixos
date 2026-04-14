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

    # Inject raw config files that use Hyprland's native syntax
    extraConfig = ''
      ${builtins.readFile ./rules.conf}
      ${builtins.readFile ./colors.conf}
    '';
  };
}
