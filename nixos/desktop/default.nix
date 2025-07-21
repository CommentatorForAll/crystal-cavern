{
  config,
  lib,
  pkgs,
  ...
}:
let
  enabled = config.crystal-cavern.roles.desktop;
in
{
  imports = [
    ./kde.nix
    ./packages.nix
    ./syncthing.nix
    ./snapper.nix
  ];
  options.crystal-cavern.roles.desktop = lib.mkEnableOption "This is a Desktop";
}
