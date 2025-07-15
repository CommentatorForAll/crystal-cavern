{
  config,
  lib,
  pkgs,
  ...
}:
let
    enabled = false;
in
{
    programs.floorp = {
        enable = true;
        languagePacks = [
            "en-US"
            "de"
        ];
        policies = {
            AppAutoUpdate = false;
            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            DisableBuiltinPDFViewer = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
        };
        profiles.default = {
            containers = {
                main = {
                    id = 1;
                    color = "blue";
                    icon = "fingerprint";
                };
                lix = {
                    id = 2;
                    color = "pink";
                    icon = "fence";
                };
                productive = {
                    id = 3;
                    color = "green";
                    icon = "briefcase";
                };
                other = {
                    id = 4;
                    color = "orange";
                    icon = "tree";
                };
            };
            containersForce = true;
            # manage extenstions here, requries NUR though, so not enabled for now.
#             extensions = {
#                 packages = with pkgs.nur.repos.rycee.firefox-addons; [
#                     ublock-origin
#                 ];
#             };
            search = {
                default = "startpage";
                privateDefault = "startpage";
                engines = {
                    nix-packages = {
                        name = "Nix Packages";
                        urls = [{
                        template = "https://search.nixos.org/packages";
                        params = [
                            { name = "type"; value = "packages"; }
                            { name = "query"; value = "{searchTerms}"; }
                        ];
                        }];

                        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        definedAliases = [ "@np" ];
                    };

                    nixos-wiki = {
                        name = "NixOS Wiki";
                        urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
                        iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                        definedAliases = [ "@nw" ];
                    };
                    bing.metaData.hidden = true;
                    google.metaData.hidden = true;
                };
                force = false;
                order = [
                    "startpage"
                    "ddg"
                ];
            };
        };

    };
}
