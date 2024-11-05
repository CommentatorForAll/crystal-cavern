{ pkgs, ... }:
{
  users.users.perovskite = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "perovskite"
      "docker"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  users.users.root.shell = pkgs.zsh;
  users.defaultUserShell = pkgs.zsh;
  users.groups.perovskite = { };
}
