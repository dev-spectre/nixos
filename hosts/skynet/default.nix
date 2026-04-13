{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname (was "nixos" — renamed to skynet)
  networking.hostName = "skynet";
  networking.networkmanager.enable = true;

  # Timezone & locale
  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT    = "en_IN";
    LC_MONETARY       = "en_IN";
    LC_NAME           = "en_IN";
    LC_NUMERIC        = "en_IN";
    LC_PAPER          = "en_IN";
    LC_TELEPHONE      = "en_IN";
    LC_TIME           = "en_IN";
  };

  # GNOME desktop (your current setup — unchanged)
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout  = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Audio (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  # User
  users.users.spectre = {
    isNormalUser = true;
    description  = "spectre";
    extraGroups  = [ "networkmanager" "wheel" ];
    packages     = with pkgs; [ ];
  };

  # Programs
  programs.firefox.enable = true;

  # Unfree (needed for NVIDIA later, harmless now)
  nixpkgs.config.allowUnfree = true;

  # System packages (add things here or move to home-manager later)
  environment.systemPackages = with pkgs; [ ];

  # Nix flakes (must be set here for the flake itself to work)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
