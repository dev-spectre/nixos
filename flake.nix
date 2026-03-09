{
  description = "Skynet NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ambxst = {
      url = "github:Axenide/Ambxst";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ambxst, ... }@inputs: {
    nixosConfigurations.skynet = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/skynet/configuration.nix 
        
        # Inject Home Manager directly into the system build
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.spectre = import ./users/spectre/home.nix;
        }

        # Ambxst
        ambxst.nixosModules.default
      ];
    };
  };
}
