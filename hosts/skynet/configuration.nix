{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix # Your custom hardware overrides
  ];

  # 1. Bootloader (GRUB)
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = false;
  boot.loader.grub.device = "nodev";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  # 2. Networking
  networking.hostName = "skynet";
  networking.networkmanager.enable = true;

  # Set timezone to India
  time.timeZone = "Asia/Kolkata";

  # 3. Audio (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 4. Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true; # GUI manager


  # 1. User Setup
  users.users.spectre = {
    isNormalUser = true;
    description = "Spectre";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  # 2. TTY Auto-Login
  # This skips the login prompt on tty1
  services.getty.autologinUser = "spectre";

  # 3. Enable Hyprland (from nixpkgs)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Needed for legacy X11 apps
  };

  # 4. Environment Variables for Nvidia & Wayland
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1"; # Forces Electron apps to use Wayland
  };

  # 5. Autostart Hyprland
  # If we are logging into tty1, immediately launch Hyprland

  # 1. Allow Proprietary Software (Vivaldi, VSCode, Nvidia)
  nixpkgs.config.allowUnfree = true;

  # 2. Shell Enablement
  programs.fish.enable = true;

  # 3. File Manager Backend
  services.gvfs.enable = true;

  # Do not change this
  system.stateVersion = "25.11"; 
}
