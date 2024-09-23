{ config, lib, ... }:
let
  enable = config.crystal-cavern.roles.server;
in
{
  config = lib.mkIf enable {

    services.prometheus = {
      enable = true;
      port = 9001;
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = 9002;
        };
      };
      scrapeConfigs =
        [
          {
            job_name = config.networking.hostName;
            static_configs = [
              { targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ]; }
            ];
          }
        ]
        ++ lib.optionals (config.networking.hostName == "quartz") [
          {
            job_name = "authentik";
            static_configs = [ { targets = [ "127.0.0.1:9300" ]; } ];
          }
        ]
        ++ lib.optionals (config.crystal-cavern.caddy.routes != { }) [
          {
            job_name = "caddy";
            static_configs = [ { targets = [ "127.0.0.1:2019" ]; } ];
          }
        ];
    };
    crystal-cavern = {
      persist.prometheus.path = "/var/lib/${config.services.prometheus.stateDir}";
    };
  };
}
