{
  nixpkgs,
  catppuccin,
  disko,
  agenix,
  home-manager,
  plasma-manager,
  authentik-nix,
  self,
  ...
}:
let
  serverUser = {
    home.stateVersion = "23.11";
    imports = [
      catppuccin.homeManagerModules.catppuccin
      self.homeManagerModules.default
    ];
  };
  mkHost =
    {
      name,
      extraModules ? [ ],
      system,
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        self.nixosModules.default
        ./hosts/${name}
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
      ] ++ extraModules;
    };
in
{
  azurite = mkHost {
    system = "aarch64-linux";
    name = "azurite";
    extraModules = [
      {
        crystal-cavern.roles.server = true;
        home-manager.users = {
          azurite = serverUser;
          root = serverUser;
        };
      }
    ];
  };
  quartz = mkHost {
    system = "aarch64-linux";
    name = "quartz";
    extraModules = [
      disko.nixosModules.disko
      agenix.nixosModules.default
      authentik-nix.nixosModules.default
      {
        crystal-cavern.roles.server = true;
        home-manager.users = {
          quartz = serverUser;
          code-server = serverUser;
          root = serverUser;
        };
      }
    ];
  };
  kyanite = mkHost {
    system = "x86_64-linux";
    name = "kyanite";
    extraModules = [
      {
        crystal-cavern.roles.desktop = true;
        home-manager.users = {
          kyanite = {
            home.stateVersion = "23.11";
            crystal-cavern.gui = true;
            imports = [
              plasma-manager.homeManagerModules.plasma-manager
              catppuccin.homeManagerModules.catppuccin
              self.homeManagerModules.default
            ];
          };
          root = {
            home.stateVersion = "23.11";
            imports = [
              plasma-manager.homeManagerModules.plasma-manager
              catppuccin.homeManagerModules.catppuccin
              self.homeManagerModules.default
            ];
          };
        };
      }
    ];
  };
}
