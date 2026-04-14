{ config, pkgs, lib, ... }:

# ---------------------------------------------------------------------------
# tty1: greetd auto-logs spectre into Hyprland with no login screen.
# After logout, falls back to tuigreet so the TTY is not abandoned.
# ---------------------------------------------------------------------------
{
  # ── Hyprland ──────────────────────────────────────────────────────────────
  programs.hyprland = {
    enable          = true;
    xwayland.enable = true;
  };

  # ── XDG portals ───────────────────────────────────────────────────────────
  xdg.portal = {
    enable        = true;
    extraPortals  = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # ── greetd — autologin on tty1 ────────────────────────────────────────────
  services.greetd = {
    enable = true;
    settings = {
      # Runs once on boot: no password prompt, straight into Hyprland
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user    = "spectre";
      };
      # Used after logout (or if you remove initial_session)
      default_session = {
        command = lib.concatStringsSep " " [
          "${pkgs.tuigreet}/bin/tuigreet"
          "--time"
          "--remember"
          "--remember-session"
          "--sessions /run/current-system/sw/share/wayland-sessions"
        ];
        user = "greeter";
      };
    };
  };

  # ── Wayland session environment ───────────────────────────────────────────
  environment.sessionVariables = {
    NIXOS_OZONE_WL      = "1";  # Electron apps use Wayland
    XDG_SESSION_TYPE    = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND  = "1";
    QT_QPA_PLATFORM     = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    WLR_NO_HARDWARE_CURSORS = "1";  # NVIDIA: prevents cursor rendering issues
  };

  # Polkit agent (needed for GUI sudo prompts in Hyprland)
  security.polkit.enable = true;
}
