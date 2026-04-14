{
  description = "spectre's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ambxst — Quickshell-based desktop shell (bar, launcher, wallpaper picker)
    ambxst = {
      url = "github:Axenide/Ambxst";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Material You color generation from wallpaper images
    matugen = {
      url = "github:InioX/matugen";
    };
  };

  outputs = { self, nixpkgs, home-manager, ambxst, matugen, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    # Apply with: sudo nixos-rebuild switch --flake .#skynet
    nixosConfigurations.skynet = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/skynet
        ambxst.nixosModules.default
      ];
    };

    # Apply with: home-manager switch --flake .#spectre@skynet
    homeConfigurations."spectre@skynet" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./users/spectre ];
    };
  };
}
