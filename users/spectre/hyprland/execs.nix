{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings."exec-once" = [
    # Ambxst desktop shell (bar, launcher, wallpaper, theming)
    "env XDG_DATA_DIRS=$XDG_DATA_DIRS ambxst"

    # Secrets / keychain
    "gnome-keyring-daemon --start --components=secrets,pkcs11"

    # D-Bus activation (needed for portals, screen sharing, etc.)
    "dbus-update-activation-environment --all"
    "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

    # Polkit agent — GUI privilege escalation
    "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

    # Cursor theme
    "hyprctl setcursor Bibata-Modern-Classic 24"
  ];
}
