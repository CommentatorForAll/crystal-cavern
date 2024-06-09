{ pkgs, ... }:
{
  users.users.kyanite = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "docker"
      "kyanite"
    ];
    initialHashedPassword = "$y$j9T$gXFIwOvd190y7Z6k01uFG/$7yJ7FdycAGIR8thBeUTiNBcNLRptjGWwB8iyQ92p40/";
    shell = pkgs.zsh;
  };
  users.users.root.shell = pkgs.zsh;
  users.groups.kyanite = { };
}
