{
  config,
  lib,
  pkgs,
  ...
}:
let
  enabled = config.crystal-cavern.roles.server;
in
{
  options.crystal-cavern.roles.server = lib.mkEnableOption "This is a Server";
  config = lib.mkIf enabled { environment.systemPackages = with pkgs; [ apacheHttpd ]; };
}
