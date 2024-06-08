{ config, lib, pkgs, ...}:

{

  services = {
    desktopManager.plasma6.enable = true;
    dbus.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    gvfs.enable = true;

    xserver = {
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
    };

    flameshot = {
        enable = true;
        settings = {
            drawThickness = 13;
            startupLaunch = true;
            useJpgForClipboard = false;
        };
    };
  };

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
    _4d-minesweeper
    syncthingtray
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
    elisa
    spectacle
    kwrited
  ];

  # Vivaldi and some IDEs require this

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (self: super: {
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
            )) {
              inherit (config.nixpkgs) config;
            };
        in
          pkgsPatched.vivaldi.override {
            qt = self.qt6;
          };
    })
  ];

  programs = {
    joplin-desktop = {
        enable = true;
        sync = {
            interval = "5m";
            target = "joplin-server";
        };
        extraConfig = {
            "spellChecker.languages" = [ "en-US" "de-DE"];
            "theme" = 22;
            "trackLocation" = false;
            "editor.spellcheckBeta" = true;
            "welcome.enabled" = false;
        };
    };
  };
}
