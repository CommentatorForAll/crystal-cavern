{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      imports = [
        inputs.nixos-flake.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      flake = {
        # Configurations for Linux (NixOS) machines
        nixosConfigurations.azurite = self.nixos-flake.lib.mkLinuxSystem {
          nixpkgs.hostPlatform = "aarch64-linux";
          imports = [
            # Setup home-manager in NixOS config
            ./hosts/azurite
            ./nixos
            inputs.catppuccin.nixosModules.catppuccin
            self.nixosModules.home-manager
            {
              crystal-cavern.roles.server = true;
              home-manager.users = {
                azurite = {
                  home.stateVersion = "23.11";
                  imports = [
                    inputs.catppuccin.homeManagerModules.catppuccin
                    self.homeModules.default
                  ];
                };
                root = {
                  home.stateVersion = "23.11";
                  imports = [
                    inputs.catppuccin.homeManagerModules.catppuccin
                    self.homeModules.default
                  ];
                };
              };
            }
          ];
        };

        # home-manager configuration goes here.
        homeModules.default = _: {
          imports = [ ./home ];
          crystal-cavern.zsh.enable = true;
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
