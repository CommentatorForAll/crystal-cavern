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
    crystal-cavern.persist.syncthing-dataDir.path = config.services.syncthing.configDir;

    services = {
      desktopManager.plasma6.enable = true;
      dbus.enable = true;
      printing = {
        enable = true;
        cups-pdf = {
          enable = true;
          instances = {
            pdf = {
              settings = {
                Out = "\${HOME}/Documents";
                UserUMask = "0033";
              };
            };
          };
        };
      };
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      gvfs.enable = true;

      xserver.xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
      syncthing = {
        enable = true;
        user = config.networking.hostName;
        group = config.networking.hostName;
        dataDir = "/home/${config.networking.hostName}";

        systemService = true;
        # Required to establish connection to azurite
        relay.enable = true;
        # settings = {
        #   options = {
        #    urAccepted = -1;
        #  };
          #           folders = {
          # #             "/home/${config.networking.hostName}/.config/joplin-desktop/plugins" = {
          # #               id = "joplin-plugins";
          # #               devices = [ "kyanite" "amethyst" "azurite" ];
          # #             };
          #           };
        #};
        overrideFolders = false;
        overrideDevices = false;
      };
    };
    programs = {
      xwayland.enable = true;
    };

    systemd.services.syncthing.serviceConfig.ReadWriteDirectories = [
      "/home/${config.networking.hostName}/"
      config.crystal-cavern.persist.syncthing-dataDir.path
    ];

    hardware.pulseaudio.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = with pkgs; [
      wayland
      xdg-utils
      vivaldi
      vivaldi-ffmpeg-codecs
      vlc
      filelight
      libreoffice
      kdePackages.kdeconnect-kde
      kdePackages.plasma-pa
      kdePackages.korganizer
      kdePackages.akonadi # dep for korganizer for caldav support
      kdePackages.kdepim-runtime # dep for korganizer for caldav support
      kdePackages.juk
      kdePackages.kio-fuse # dep for smb discovery?
      kdePackages.kio-zeroconf
      kdePackages.kio-extras
      kdePackages.libkscreen
      syncthingtray
      _4d-minesweeper
      unrar
      openscad-unstable
    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      oxygen
      spectacle
      kwrited
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Vivaldi and some IDEs require this

    nixpkgs.config.allowUnfree = true;

    nixpkgs.overlays = [
      (self: _super: {
        vivaldi =
          let
            pkgsPatched =
              (import (
                self.applyPatches {
                  src = self.path;
                  patches = [
                    (self.fetchpatch {
                      url = "https://github.com/NixOS/nixpkgs/pull/292148.patch";
                      hash = "sha256-gaH4UxKi2s7auoaTmbBwo0t4HuT7MwBuNvC/z2vvugE=";
                    })
                  ];
                }
              ))
                { inherit (config.nixpkgs) config system; };
          in
          pkgsPatched.vivaldi.override { qt = self.qt6; };
      })
    ];
  };
  options.crystal-cavern.roles.desktop = lib.mkEnableOption "This is a Desktop";
}
