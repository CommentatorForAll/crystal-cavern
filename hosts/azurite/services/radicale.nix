_:
let
  port = 5232;
  data_path = "/var/lib/radicale/collections";
  secrets_path = "/persist/secrets/radicale";
in
{
  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [ "127.0.0.1:${builtins.toString port}" ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "${secrets_path}/htpasswd";
        htpasswd_encryption = "bcrypt";
      };
      storage = {
        filesystem_folder = "/persist/data/radicale";
      };
    };
  };

  crystal-cavern = {
    caddy.routes."calendar.blackdemon.tech".port = port;
    #persist.radicale.path = data_path;
  };
}
