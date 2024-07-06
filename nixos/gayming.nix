{
  config,
  lib,
  pkgs,
  ...
}:
let
  enabled = config.crystal-cavern.roles.gayming;
in
{
  config = lib.mkIf enabled {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      lutris
      wineWowPackages.waylandFull
      prismlauncher
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
