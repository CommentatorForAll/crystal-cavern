{
  config,
  lib,
  pkgs,
  ...
}:
let
  enabled = config.crystal-cavern.roles.desktop;
  unstable = import (import ../../npins).nixpkgs-unstable {inherit (pkgs) system;};
in
{
  config = lib.mkIf enabled {
    services = {
      desktopManager.plasma6.enable = true;
      dbus.enable = true;

      displayManager = {
        autoLogin = {
          enable = false;
          user = config.networking.hostName;
        };
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      gvfs.enable = true;

      xserver.xkb = {
        layout = "us";
        variant = "altgr-intl";
      };

    };
    programs = {
      xwayland.enable = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      oxygen
      kwrited
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

  };
}
