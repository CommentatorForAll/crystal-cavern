{
  config,
  lib,
  pkgs,
  ...
}:
let
  enabled = config.crystal-cavern.roles.coding;
in
{
  config = lib.mkIf enabled {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      jetbrains.clion
      jetbrains.pycharm-professional
      python313
    ];
  };

  options.crystal-cavern.roles.coding = lib.mkOption {
    type = lib.types.bool;
    description = "If you want to code some stuff on the fly without flaking everything";
    default = false;
  };
}
