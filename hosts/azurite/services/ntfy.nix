_:
let
  path = "/persist/data/ntfy";
  port = 50144;
  url = "ntfy.blackdemon.tech";
in
{
  services.ntfy-sh = {
    settings = {
      auth-file = "${path}/user.db";
      listen-http = "127.0.0.1:${builtins.toString port}";
      attachment-cache-dir = "${path}/attachments";
      cache-file = "${path}/cache-file.db";
      base-url = "https://${url}";
      auth-default-access = "write-only";
    };
    enable = true;
  };
  systemd.services.ntfy-sh.serviceConfig.ReadWritePaths = [ path ];
  crystal-cavern.caddy.routes."${url}".port = port;
}
