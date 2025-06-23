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
  unstable = import (import ../npins).nixpkgs-unstable { inherit (pkgs) system; };
  autostart = config.crystal-cavern.autostart;
in
{
  config = lib.mkIf enabled {
    nixpkgs.overlays = [
    	(self: super: {inherit (unstable)
          # Place packages here, which should be pulled from unstalbe instead of current stable branch
		;})
    ];
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
          resetFiles = [
            "autostart/*"
          ];
          shortcuts = {
            # "services/org.flameshot.Flameshot.desktop"."Capture" = "Print";
          };
          configFile = {}
            // lib.optionalAttrs autostart.vesktop {
              "autostart/vesktop.desktop"."Desktop Entry" = {
                  Categories = "Network;InstantMessaging;Chat";
                  Exec = "vesktop %U";
                  Icon = "vesktop";
                  Name = "Vesktop";
                  StartupWMClass="Vesktop";
                  Type = "Application";
                  Version = "1.4";
              };
            }
            // lib.optionalAttrs (autostart.browser != null) {
            "autostart/browser.desktop" = lib.mkIf (autostart.browser != null) {
                Exec = autostart.browser + "%U";
                Icon = autostart.browser;
                Type = "Application";
                StartupWMClass = autostart.browser;
                Name = autostart.browser;
            };}
            // lib.optionalAttrs autostart.element {
              "autostart/element.desktop"."Desktop Entry" = {
                Categories = "Network;InstantMessaging;Chat";
                Exec = "element-desktop %U";
                Icon = "element-desktop";
                Name = "Element";
                StartupWMClass="Element";
                Type = "Application";
              };
            }
          ;
          session = {
            general = {
              askForConfirmationOnLogout = true;
            };
            sessionRestore = {
              excludeApplications = [
                "korganizer"
                "kate"
              ];
              restoreOpenApplicationsOnLogin = null;
            };
          };
          input = {
            keyboard = {
              numlockOnStartup = "on";
            };
          };
          panels = [
            {
              alignment = "left";
              floating = "false";
              location = "bottom";
              opacity = "opaque";
              screen = "all";
            }
          ];
          workspace = {
            theme = "breeze-dark";
            colorScheme = "BreezeDark";
            cursor.theme = "breeze_cursors";
            lookAndFeel = "org.kde.breezedark.desktop";
          };
        };
      };
    services = {
#       flameshot = {
#         enable = true;
#         settings.General = {
#           drawThickness = 13;
#           startupLaunch = true;
#           useJpgForClipboard = false;
#         };
#       };
    };
  };
  options.crystal-cavern.gui = lib.mkOption {
    type = lib.types.bool;
    description = "Whether to configure gui tools";
    default = false;
  };
  options.crystal-cavern.autostart = {
      vesktop = lib.mkEnableOption "autostart vesktop?";
      element = lib.mkEnableOption "autostart element?";
      browser = lib.mkOption {
        type = lib.types.nullOr lib.types.string;
        description = "What browser package to use";
        default = null;
      };
  };
}
