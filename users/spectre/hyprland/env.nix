{ ... }:

{
  wayland.windowManager.hyprland.settings.env = [
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"
    "ELECTRON_OZONE_PLATFORM_HINT,auto"
    "XDG_DATA_DIRS,$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:/run/current-system/sw/share:/etc/profiles/per-user/spectre/share"
    "QT_QPA_PLATFORM,wayland;xcb"
    "QT_QPA_PLATFORMTHEME,kde"
    "XDG_MENU_PREFIX,plasma-"
    "TERMINAL,kitty -1"
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_TYPE,wayland"
    "XDG_SESSION_DESKTOP,Hyprland"
  ];
}
