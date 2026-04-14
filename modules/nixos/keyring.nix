{ pkgs, lib, ... }:

# ---------------------------------------------------------------------------
# GNOME Keyring — auto-unlock for autologin (greetd initial_session).
#
# Since greetd skips the password prompt, PAM never receives a password to
# forward to gnome-keyring.  The keyring must therefore have an **empty**
# password set (done once via Seahorse or secret-tool after first boot).
# ---------------------------------------------------------------------------
{
  # Enable gnome-keyring system-wide (installs daemon + PAM modules)
  services.gnome.gnome-keyring.enable = true;

  # Wire the PAM module so greetd / login unlock the keyring automatically
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring  = true;

  # CLI tooling for keyring debugging
  environment.systemPackages = with pkgs; [
    seahorse        # GUI: Passwords & Keys
    libsecret       # CLI: secret-tool
  ];
}
