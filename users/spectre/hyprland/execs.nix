{ ... }:

{
  wayland.windowManager.hyprland.settings."exec-once" = [
    "env XDG_DATA_DIRS=$XDG_DATA_DIRS ambxst"
    "gnome-keyring-daemon --start --components=secrets"
    "dbus-update-activation-environment --all"
    "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "easyeffects --hide-window --service-mode"
    "hyprctl setcursor Bibata-Modern-Classic 24"
  ];
}
