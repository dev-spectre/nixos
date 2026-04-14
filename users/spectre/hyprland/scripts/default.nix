{ pkgs, ... }:

{
  home.packages = [
    (import ./launch_first_available.nix { inherit pkgs; })
    (import ./workspace_action.nix { inherit pkgs; })
    (import ./zoom_cursor.nix { inherit pkgs; })
  ];
}
