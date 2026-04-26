{
  description = "My home configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = { system, module }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ module ];
        };
    in {
      homeConfigurations = {
        "x7c1@ubuntu" = mkHome {
          system = "x86_64-linux";
          module = ./hosts/ubuntu.nix;
        };

        "x7c1@macos" = mkHome {
          system = "aarch64-darwin";
          module = ./hosts/macos.nix;
        };
      };
    };
}
