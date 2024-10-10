{
  nixConfig.allow-import-from-derivation = true;
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    authentik-nix = {
      url = "github:nix-community/authentik-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        darwin.follows = "";
      };
    };
  };

  outputs =
    inputs@{
      agenix,
      flake-parts,
      treefmt-nix,
      self,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      imports = [ treefmt-nix.flakeModule ];

      flake = {
        # Configurations for Linux (NixOS) machines
        nixosConfigurations = import ./entry.nix inputs;
        homeManagerModules.default = import ./home;
        nixosModules.default = import ./nixos;
      };
      perSystem =
        {
          lib,
          pkgs,
          system,
          ...
        }:
        {
          packages = {
          	yomikiru = pkgs.callPackage ./pkgs/yomikiru.nix {};
          };
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              agenix.packages.${system}.default
              deadnix
              statix
              nixfmt-rfc-style
              nil
              npins
            ];
          };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt-rfc-style.enable = true;
              deadnix.enable = true;
              statix.enable = true;
            };
          };
          checks =
            let
              nixosMachines = lib.mapAttrs' (
                name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel
              ) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.nixosConfigurations);
            in
            nixosMachines;
        };
    };
}
