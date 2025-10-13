{
  config,
  lib,
  pkgs,
  ...
}:
let
  enabled = config.crystal-cavern.roles.gayming;
  unstable = import (import ../npins).nixpkgs-unstable {inherit (pkgs) system;};
in
{
  config = lib.mkIf enabled {
    nixpkgs.overlays = [
      (self: super: {
        olympus =
          let pkgsPatched = (import (
            self.applyPatches {
              src = self.path;
              patches = [
                (self.fetchpatch {
                  url = "https://github.com/NixOS/nixpkgs/pull/309327.patch";
                  sha256 = "sha256-Yugogh6w5hZAiljWRU8DUArYrfoSH+3v5uRaMMUwdgc=";
                })
              ];
            }
          ))
          {inherit (config.nixpkgs) config system;};
        in
          pkgsPatched.olympus;
        })
    ];


    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      lutris
      wineWowPackages.waylandFull
      prismlauncher
      mangohud
      olympus
      kdePackages.kpat
      unstable.satisfactorymodmanager
    ];
    programs = {
      steam = {
        enable = true;
      };
    };
    crystal-cavern.roles.desktop = lib.mkForce true;
  };

  options.crystal-cavern.roles.gayming = lib.mkOption {
    type = lib.types.bool;
    description = "If you want to do gayming";
    default = false;
  };
}
