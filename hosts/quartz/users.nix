{ pkgs, ... }:
{
  users.users.quartz = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "quartz"
      "docker"
    ];
    initialHashedPassword = "$y$j9T$jjoMCVV2jt7mzWBo1fYue1$MXU75DhLGvglzEdwiFQBl7AVYXElgmfbzRLSsb.0FC2";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = (import ../../keys.nix).ssh;
  };
  users.users.root.shell = pkgs.zsh;
  users.groups.quartz = { };
}
