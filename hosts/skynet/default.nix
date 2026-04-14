{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/keyring.nix
  ];

  # ── Bootloader ────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── Networking ────────────────────────────────────────────────────────────
  networking.hostName             = "skynet";
  networking.networkmanager.enable = true;

  # ── Timezone & locale ────────────────────────────────────────────────────
  time.timeZone      = "Asia/Kolkata";
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

  # ── Keyboard layout ──────────────────────────────────────────────────────
  services.xserver.xkb = {
    layout  = "us";
    variant = "";
  };

  # ── Printing ──────────────────────────────────────────────────────────────
  services.printing.enable = true;

  # ── Audio (Pipewire) ──────────────────────────────────────────────────────
  services.pulseaudio.enable = false;
  security.rtkit.enable      = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  # ── Bluetooth ─────────────────────────────────────────────────────────────
  hardware.bluetooth.enable      = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable        = true;

  # ── User ──────────────────────────────────────────────────────────────────
  users.users.spectre = {
    isNormalUser = true;
    description  = "spectre";
    extraGroups  = [ "networkmanager" "wheel" "video" "input" "audio" ];
    shell        = pkgs.bashInteractive;
    packages     = with pkgs; [ ];
  };

  # ── Shell ─────────────────────────────────────────────────────────────────
  programs.fish.enable = true;

  # ── System packages ──────────────────────────────────────────────────────
  programs.firefox.enable    = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    kitty
    git
    nano
    antigravity
    curl
    wget
  ];

  # ── File manager backend ─────────────────────────────────────────────────
  services.gvfs.enable = true;

  # ── dconf (needed by GNOME and GTK apps) ─────────────────────────────────
  programs.dconf.enable = true;

  # ── Nix settings ─────────────────────────────────────────────────────────
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store   = true;
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 7d";
  };

  system.stateVersion = "25.11";
}
