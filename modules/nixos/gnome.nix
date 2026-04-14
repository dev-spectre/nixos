{ config, pkgs, lib, ... }:

# ---------------------------------------------------------------------------
# tty2: a second greetd instance shows a session picker (GNOME + others).
# Reach it with Ctrl+Alt+F2.
#
# GDM is intentionally NOT used — greetd handles both TTYs.
# GNOME is installed as a desktop session; it appears in the picker.
# ---------------------------------------------------------------------------
{
  # ── GNOME desktop ─────────────────────────────────────────────────────────
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;

  # Disable GDM — greetd handles both TTYs.
  services.displayManager.gdm.enable = lib.mkForce false;

  # dconf is required for GNOME settings to persist
  programs.dconf.enable = true;

  # Remove a handful of pre-installed GNOME apps you likely don't want
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    gnome-music
  ];

  # ── greetd config for tty2 ────────────────────────────────────────────────
  # Written to /etc/greetd/config-tty2.toml and read by the service below.
  # Lists both xsessions (X11) and wayland-sessions so GNOME Wayland appears.
  environment.etc."greetd/config-tty2.toml".text = ''
    [terminal]
    vt = 2

    [default_session]
    command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions /run/current-system/sw/share/xsessions:/run/current-system/sw/share/wayland-sessions"
    user = "greeter"
  '';

  # ── Second greetd systemd unit on tty2 ────────────────────────────────────
  systemd.services.greetd-tty2 = {
    description = "greetd session picker on tty2 (GNOME)";
    # Start after the main greetd has claimed tty1
    after    = [ "systemd-user-sessions.service" "greetd.service" ];
    before   = [ "shutdown.target" ];
    wants    = [ "systemd-user-sessions.service" ];
    wantedBy = [ "graphical.target" ];

    serviceConfig = {
      Type      = "idle";
      ExecStart = "${pkgs.greetd}/bin/greetd --config /etc/greetd/config-tty2.toml";
      Restart   = "on-failure";
      # Must own the TTY for PAM session launching to work
      StandardInput    = "tty";
      TTYPath          = "/dev/tty2";
      TTYReset         = "yes";
      TTYVHangup       = "yes";
      TTYVTDisallocate = "yes";
    };
  };
}
