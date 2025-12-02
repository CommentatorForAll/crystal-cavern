{ pkgs, ... }:
{
  users.users = {
    perovskite = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "perovskite"
        "docker"
        "audio"
      ];
      shell = pkgs.zsh;
    };
    catio3 = {
      isNormalUser = true;
      extraGroups = [

      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = (import ../../keys.nix).ssh;
    };
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  users.users.root.shell = pkgs.zsh;
  users.defaultUserShell = pkgs.zsh;
  users.groups.perovskite = { };
  users.groups.catio3 = { };

  nix.settings.trusted-users = [
    "perovskite"
    "catio3"
    "root"
  ];
}
