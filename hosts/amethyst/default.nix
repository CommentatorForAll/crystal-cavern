{ pkgs, ...}:

{
    imports = [
        ./hardware-configuration.nix
        ./users.nix
    ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.grub.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "amethyst";
    networking.networkmanager.enable = true;
    environment.systemPackages = with pkgs; [
        musescore
        element-desktop
        discord
    ];

	boot.initrd.luks.devices = {
		root = {
			device = "/dev/nvme0n1p2";
			preLVM = true;
		};
	};

	# boot.loader.grub.device = "/dev/nvme0n1";

    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "en_US.UTF-8";

    system.stateVersion = "24.05";
}
