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
  config = lib.mkIf enabled {
    # Run: tailscale up --login-server https://headscale.elia.garden
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
