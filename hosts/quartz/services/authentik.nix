{ config, ... }:
let
  url = "auth.blackdemon.tech";
  port = 9000;
in
{
  age.secrets.quartz-authentik.file = ../../../secrets/quartz/authentik.age;
  services.authentik = {
    enable = true;
    # inherit port;
    environmentFile = config.age.secrets.quartz-authentik.path;
  };
  crystal-cavern = {
    caddy = {
      routes."${url}".port = port;
      sso = "http://localhost:${builtins.toString port}";
    };
    persist.authentik-media.path = "/var/lib/authentik/media";
  };
}
