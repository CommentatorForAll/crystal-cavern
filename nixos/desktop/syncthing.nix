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
        services = {
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
        crystal-cavern.persist.syncthing-dataDir = {
            path = config.services.syncthing.configDir;
            owner = config.services.syncthing.user;
            group = config.services.syncthing.group;
        };

        systemd.services.syncthing.serviceConfig.ReadWriteDirectories = [
            "/home/${config.networking.hostName}/"
            config.crystal-cavern.persist.syncthing-dataDir.path
        ];

    };
}
