# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./users.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kyanite"; # Define your hostname.
  environment.systemPackages = with pkgs; [ musescore ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  networking.hosts = {
    "127.0.0.1" = [
      "intern"
      "extern"
      "localhost"
    ];
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "23.11";
}
