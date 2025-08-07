{
  description = "RangeNix";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      host = "nixos-vm";
      username = "rangeler";
      profile = "vm";
    in {
      nixosConfigurations = {
        ${host} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/nixos-vm ];
          specialArgs = {
            inherit host;
            inherit username;
          };
        };
      };
    };
}
