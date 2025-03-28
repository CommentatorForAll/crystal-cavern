{ pkgs, ... }:
{
  users.users.celestine = {
    isNormalUser = true;
    description = "celestine";
    extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
        "docker"
        "celestine"
    ];
    shell =pkgs.zsh;
  };

  users.users.root.shell = pkgs.zsh;
  users.groups.kyanite = { };
}
