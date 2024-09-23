{ config, lib, ... }:
let
  domain = "grafana.${config.networking.hostName}.blackdemon.tech";
  enable = config.crystal-cavern.roles.server;
  host = config.networking.hostName;
in
{
  config = lib.mkIf enable {
    age.secrets."${host}-grafana".file = ../../secrets/${host}/grafana.age;

    services.grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3000;
          inherit domain;
          root_url = "https://${domain}";
        };
      };
    };
    systemd.services.grafana.serviceConfig.EnvironmentFile = config.age.secrets."${host}-grafana".path;
    crystal-cavern = {
      persist.grafana = {
        path = config.services.grafana.dataDir;
      };
      caddy.routes."${domain}".port = 3000;
    };
  };
}
