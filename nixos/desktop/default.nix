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
    crystal-cavern.persist.syncthing-dataDir.path = config.services.syncthing.configDir;

	nixpkgs.overlays = [
		(self: super: {inherit (unstable)
          # Place packages here, which should be pulled from unstalbe instead of current stable branch
		;})
# 		(self: _super: {
# 		        vivaldi =
# 		          let
# 		            pkgsPatched =
# 		              (import (
# 		                self.applyPatches {
# 		                  src = self.path;
# 		                  patches = [
# 		                    (self.fetchpatch {
# 		                      url = "https://github.com/NixOS/nixpkgs/pull/292148.patch";
# 		                      hash = "sha256-gaH4UxKi2s7auoaTmbBwo0t4HuT7MwBuNvC/z2vvugE=";
# 		                    })
# 		                  ];
# 		                }
# 		              ))
# 		                { inherit (config.nixpkgs) config system; };
# 		          in
# 		          pkgsPatched.vivaldi.override { qt = self.qt6; };
# 		      })
	];

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
      displayManager = {
        autoLogin = {
          enable = true;
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
      syncthing = {
        enable = true;
        user = config.networking.hostName;
        group = config.networking.hostName;
        dataDir = "/home/${config.networking.hostName}";

        systemService = true;
        # Required to establish connection to azurite // nvm, this is the relay itself
        # relay.enable = true;
        settings = {
          options = {
            relaysEnabled = true;
        #    urAccepted = -1;
          };
          #           folders = {
          # #             "/home/${config.networking.hostName}/.config/joplin-desktop/plugins" = {
          # #               id = "joplin-plugins";
          # #               devices = [ "kyanite" "amethyst" "azurite" ];
          # #             };
          #           };
        };
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

    # hardware.pulseaudio.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = with pkgs; [
      wayland
      xdg-utils
      (vivaldi.overrideAttrs
      (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
      }))
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
      element-desktop
      vesktop
      jellyfin-media-player
    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      oxygen
      kwrited
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Vivaldi and some IDEs require this

    nixpkgs.config.allowUnfree = true;
  };
  options.crystal-cavern.roles.desktop = lib.mkEnableOption "This is a Desktop";
}
