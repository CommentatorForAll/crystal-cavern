{ pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PrintMotd = true;
      KbdInteractiveAuthentication = false;
    };
  };
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    tree
    htop
    iftop
    iotop
    wget
    curl
    fastfetch
    syncthing
    nix-tree
    ffmpeg
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
