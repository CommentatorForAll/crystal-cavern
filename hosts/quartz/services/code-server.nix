_:
let
  url = "code-server.blackdemon.tech";
  port = 4444;
in
{
  services.code-server = {
    enable = true;
    inherit port;
    auth = "none";
    disableUpdateCheck = true;
  };
  crystal-cavern.caddy.routes."${url}" = {
    inherit port;
    useSso = true;
  };
}
