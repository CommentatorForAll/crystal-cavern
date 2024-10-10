{
  config,
  options,
  lib,
  pkgs,
  ...
}:
let
  enabled = config.crystal-cavern.gui;
  enablePlasma = builtins.hasAttr "plasma" options.programs;
  unstable = import (builtins.fetchTarball {url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"; sha256 = "12c9gz8agsajy6gbaj8m7r69d485pmccjnzgwz0szv6iys6kf812";}){ inherit (pkgs) system; };
in
{
  config = lib.mkIf enabled {
    home.packages = with pkgs; [ fira-code-nerdfont ];
    programs =
      {
        joplin-desktop = {
          enable = true;
          package = unstable.joplin-desktop;
          sync = {
            interval = "5m";
            target = "joplin-server";
          };
          extraConfig = {
            "spellChecker.languages" = [
              "en-US"
              "de-DE"
            ];
            "theme" = 22;
            "trackLocation" = false;
            "editor.spellcheckBeta" = true;
            "welcome.enabled" = false;
          };
        };
      }
      // lib.optionalAttrs enablePlasma {
        plasma = {
          shortcuts = {
            "services/org.flameshot.Flameshot.desktop"."Capture" = "Print";
          };
          configFile = {
            "plasma-localerc"."Formats"."LANG" = "de_DE.UTF-8";
            "plasma-localerc"."Translations"."LANGUAGE" = "en_US.UTF-8";
          };
          workspace = {
            theme = "breeze-dark";
            colorScheme = "BreezeDark";
            cursor.theme = "breeze_cursors";
            lookAndFeel = "org.kde.breezedark.desktop";
          };
        };
      };
    services = {
      flameshot = {
        enable = true;
        settings.General = {
          drawThickness = 13;
          startupLaunch = true;
          useJpgForClipboard = false;
        };
      };
    };
  };
  options.crystal-cavern.gui = lib.mkOption {
    type = lib.types.bool;
    description = "Whether to configure gui tools";
    default = false;
  };
}
