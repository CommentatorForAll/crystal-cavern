{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      catppuccin,
      flake-parts,
      home-manager,
      nixpkgs,
      treefmt-nix,
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
        nixosConfigurations = {
          azurite = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              # Setup home-manager in NixOS config
              ./hosts/azurite
              ./nixos
              catppuccin.nixosModules.catppuccin
              home-manager.nixosModules.home-manager
              {
                crystal-cavern.roles.server = true;
                home-manager.users = {
                  azurite = {
                    home.stateVersion = "23.11";
                    imports = [
                      catppuccin.homeManagerModules.catppuccin
                      ./home
                    ];
                  };
                  root = {
                    home.stateVersion = "23.11";
                    imports = [
                      catppuccin.homeManagerModules.catppuccin
                      ./home
                    ];
                  };
                };
              }
            ];
          };
          quartz = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              ./hosts/quartz
              ./nixos
              catppuccin.nixosModules.catppuccin
              home-manager.nixosModules.home-manager
              {
                crystal-cavern.roles.server = true;
                home-manager.users = {
                  quartz = {
                    home.stateVersion = "23.11";
                    imports = [
                      catppuccin.homeManagerModules.catppuccin
                      ./home
                    ];
                  };
                  root = {
                    home.stateVersion = "23.11";
                    imports = [
                      catppuccin.homeManagerModules.catppuccin
                      ./home
                    ];
                  };
                };
              }
            ];
          };
        };
      };
      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nixfmt-rfc-style
              nil
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
        };
    };
}
