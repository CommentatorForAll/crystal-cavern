{
  nixpkgs,
  disko,
  agenix,
  home-manager,
  plasma-manager,
  authentik-nix,
  spicetify-nix,
  self,
  ...
}:
let
  serverUser = {
    home.stateVersion = "23.11";
    imports = [
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
        home-manager.nixosModules.home-manager
        spicetify-nix.nixosModules.spicetify
      ] ++ extraModules;
      specialArgs = {
        inherit spicetify-nix;
      };
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
  amethyst = mkHost {
    system = "x86_64-linux";
    name = "amethyst";
    extraModules = [
      {
        crystal-cavern.roles = {
          desktop = true;
          gayming = true;
        };
        home-manager.users = {
          amethyst = {
            home.stateVersion = "24.05";
            crystal-cavern.gui = true;
            imports = [
              plasma-manager.homeModules.plasma-manager
              self.homeManagerModules.default
              ./home
            ];
          };
          root = {
            home.stateVersion = "24.05";
            imports = [
              plasma-manager.homeModules.plasma-manager
              self.homeManagerModules.default
              ./home
            ];
          };
        };
      }
    ];
  };
  perovskite = mkHost {
  	system = "x86_64-linux";
  	name = "perovskite";
  	extraModules = [
  		{
  		crystal-cavern.roles = {
  			desktop = true;
  			gayming = true;
  			coding = true;
  		};
  		home-manager.users = {
  			perovskite = {
  				home.stateVersion = "24.05";
  				crystal-cavern.gui = true;
                crystal-cavern.autostart = {
                  vesktop = true;
                  element = true;
                  browser = "floorp";
                };
  				imports = [
  					plasma-manager.homeModules.plasma-manager
  					self.homeManagerModules.default
  					./home
  				];
  			};
  			catio3 = {
  				home.stateVersion = "25.05";
  				crystal-cavern.gui = false;
  				imports = [
  					self.homeManagerModules.default
  					./home
  				];
  			};
  			root = {
  				home.stateVersion = "24.05";
  				imports = [
  					plasma-manager.homeModules.plasma-manager
  					self.homeManagerModules.default
  					./home
  				];
  			};
  		};
  		}
  	];
  };
  celestine = mkHost {
  	system = "x86_64-linux";
  	name = "celestine";
  	extraModules = [
  		{
  			crystal-cavern.roles = {
  				desktop = true;
  				gayming = true;
  				coding = true;
  			};
  			home-manager.users = {
  				celestine = {
  					home.stateVersion = "24.11";
  					crystal-cavern.gui = true;
  					imports = [
  						plasma-manager.homeModules.plasma-manager
  						self.homeManagerModules.default
  						./home
  					];
  				};
  				root = {
  					home.stateVersion = "24.11";
  					imports = [
  						plasma-manager.homeModules.plasma-manager
  						self.homeManagerModules.default
  						./home
  					];
  				};
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
        crystal-cavern.roles = {
          desktop = true;
          coding = true;
          gayming =true;
        };
        home-manager.users = {
          kyanite = {
            home.stateVersion = "23.11";
            crystal-cavern.gui = true;
            imports = [
              plasma-manager.homeModules.plasma-manager
              self.homeManagerModules.default
            ];
          };
          root = {
            home.stateVersion = "23.11";
            imports = [
              plasma-manager.homeModules.plasma-manager
              self.homeManagerModules.default
            ];
          };
        };
      }
    ];
  };
}
