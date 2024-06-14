{ pkgs, ...}:

{
    imports = [
        ./hardware-configuration.nix
        ./users.nix
    ];

    boot.loader.system-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "amethyst";
    networking.networkmanager.enable = true;
    environment.systemPackages = with pkgs; [
        musescore
        element-desktop
        discord
    ];

    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "en_US.UTF-8";

    system.stateVersion = "24.05";
}
