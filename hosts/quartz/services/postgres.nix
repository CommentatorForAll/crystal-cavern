{ config, ... }:
{
  services.postgresql = {
    ensureUsers = [
      {
        name = "blizzbot";
        ensureDBOwnership = true;
      }
      {
        name = "twitchbot";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [
      "blizzbot"
      "twitchbot"
    ];
    identMap = ''
      code-server code-server blizzbot
      code-server code-server twitchbot
    '';
  };
  crystal-cavern.persist.postgres = {
    path = config.services.postgresql.dataDir;
    mode = "750";
    owner = "postgres";
    group = "postgres";
  };
}
