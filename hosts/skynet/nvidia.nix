{ config, pkgs, ... }:

# ---------------------------------------------------------------------------
# NVIDIA RTX 3050 (Laptop) — proprietary drivers with Intel PRIME offload.
# modesetting.enable is critical for Hyprland on Wayland.
#
# To find your bus IDs:
#   nix shell nixpkgs#pciutils -c lspci | grep -i vga
# ---------------------------------------------------------------------------
{
  # ── OpenGL / Vulkan ──────────────────────────────────────────────────────
  hardware.graphics.enable      = true;
  hardware.graphics.enable32Bit = true;

  # ── NVIDIA driver for Xorg + Wayland ─────────────────────────────────────
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable          = true;   # Required for Hyprland
    powerManagement.enable      = false;
    powerManagement.finegrained = false;
    open                        = false;  # Proprietary — best for RTX 3050
    nvidiaSettings              = true;

    # ── PRIME (Intel iGPU + NVIDIA dGPU) ─────────────────────────────────
    prime = {
      offload.enable           = true;
      offload.enableOffloadCmd = true;

      # Replace with your actual PCI bus IDs if different
      intelBusId  = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
