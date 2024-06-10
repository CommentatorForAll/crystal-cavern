{
  nixConfig.allow-import-from-derivation = true;
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts={url = "github:hercules-ci/flake-parts";};
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
  };

  outputs =
    inputs@{
      catppuccin,
      disko,
      flake-parts,
      home-manager,
      nixpkgs,
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
              disko.nixosModules.disko
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
          kyanite = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/kyanite
              ./nixos
              catppuccin.nixosModules.catppuccin
              home-manager.nixosModules.home-manager
              inputs.plasma-manager.homeManagerModules.plasma-manager
              {
                crystal-cavern.roles.desktop = true;
                home-manager.users = {
                  kyanite = {
                    home.stateVersion = "23.11";
                    crystal-cavern.gui = true;
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
        {
          lib,
          pkgs,
          system,
          self',
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              deadnix
              statix
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
          checks =
            let
              nixosMachines = lib.mapAttrs' (
                name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel
              ) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.nixosConfigurations);
              devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
            in
            nixosMachines // devShells;
        };
    };
}
