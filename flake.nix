{
  description = "RangeNix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "nixstation";
      username = "rangeler";
    in {
      nixosConfigurations = {
        ${host} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/nixstation ];
          specialArgs = {
            inherit host;
            inherit username;
            inherit inputs;
          };
        };
      };
    };
}
