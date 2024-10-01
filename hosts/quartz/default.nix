{
  config,
  lib,
  pkgs,
  ...
}:
let
  keys = import ../../keys.nix;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
    ./users.nix
    ./services
    ./disko.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    initrd = {
      network = {
        enable = true;
        udhcpc.enable = lib.mkDefault true;

        postCommands = ''
          if type "zpool" > /dev/null; then
            # Import all pools
            zpool import -a
          fi
        '';
        ssh = {
          enable = true;
          port = 2222;
          authorizedKeys = keys.ssh;
          hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
        };
      };
    };

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        zfsSupport = true;
        device = "nodev";
      };

      efi.canTouchEfiVariables = true;
    };
    zfs = {
      allowHibernation = true;
      forceImportRoot = false;
    };
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };

  networking = {
    hostName = "quartz"; # Define your hostname.
    hostId = "8bd12591";
  };
  environment.systemPackages = with pkgs; [
    micro
    wget
  ];
  services.openssh = {
    enable = true;
    openFirewall = true;
  };
  nix = {
  	package = pkgs.lix;
  	settings = {
  	  experimental-features = [ "nix-command" "flakes" ];

  	  
      # Lix binary cache
      extra-substituters = [ "https://cache.lix.systems" ];
      trusted-public-keys = [ "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o=" ];
      trusted-users = [ "root" "quartz" ];
  	};
  };

  system.stateVersion = "23.11";
}
