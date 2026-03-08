{ config, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true; # CRITICAL for Hyprland
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # Use proprietary drivers for the RTX 3050
    nvidiaSettings = true;

    # PRIME Configuration (Intel + Nvidia)
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      
      # YOU MUST REPLACE THESE WITH YOUR ACTUAL BUS IDS
      # Run `nix shell nixpkgs#pciutils -c lspci | grep -i vga` to find them
      intelBusId = "PCI:0:2:0"; 
      nvidiaBusId = "PCI:1:0:0"; 
    };
  };
}
