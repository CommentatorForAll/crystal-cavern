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

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  environment.systemPackages = with pkgs; [
    nerd-fonts.fira-code
    git
    lazygit
    tree
    htop
    iftop
    iotop
    wget
    curl
    fastfetch
    nix-tree
    ffmpeg
    micro
    ripgrep
    unzip
    lm_sensors
    fd
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
