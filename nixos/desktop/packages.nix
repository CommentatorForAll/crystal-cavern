{
  config,
  lib,
  pkgs,
  spicetify-nix,
  ...
}:
let
  enabled = config.crystal-cavern.roles.desktop;
  unstable = import (import ../../npins).nixpkgs-unstable {inherit (pkgs) system;};
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  config = lib.mkIf enabled {
    # Vivaldi and some IDEs require this

    nixpkgs.config.allowUnfree = true;

	nixpkgs.overlays = [
		(self: super: {inherit (unstable)
          # Place packages here, which should be pulled from unstalbe instead of current stable branch
          npins
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
    environment.systemPackages = with pkgs; [
      (vivaldi.overrideAttrs
      (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
      }))
      vivaldi
      vivaldi-ffmpeg-codecs
      vlc
      kdePackages.filelight
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
      config.programs.spicetify.spicedSpotify
      npins
    ];
    services = {
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
    };
    programs = {
        spicetify = {
            enable = true;
            enabledExtensions = with spicePkgs.extensions; [
                shuffle
                songStats
                history
            ];
            enabledCustomApps = with spicePkgs.apps; [
                marketplace
                nameThatTune
            ];
            theme = spicePkgs.themes.catppuccin;
            colorScheme = "mocha";
        };
    };
  };
}
