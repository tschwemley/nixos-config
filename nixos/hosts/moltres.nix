{
  self,
  config,
  lib,
  ...
}: let
  diskConfig = import ../hardware/disks/btrfs-ephemeral.nix {
    diskName = "/dev/vda";
    swapSize = "-4G";
  };
in {
  imports = [
    diskConfig
    ./profiles/server.nix
    # ../services/k3s
    # ../services/keycloak.nix
    ../users/k3s.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd"];
    supportedFilesystems = ["btrfs"];
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = ["/dev/vda"];
      };
    };
  };

  networking.hostName = "moltres";
  # networking = {
  #   hostName = "molters";
  #   networkmanager.enable = true;
  #   useDHCP = lib.mkDefault true;
  # };

  # services.getty.autologinUser = "k3s";
  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ../../secrets/moltres.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    # Specify machine secrets
    secrets = {
	  k3s_user_password = {
		 neededForUsers = true; 
	  };
      systemd_networkd = {
		mode = "0644";
        path = "/etc/systemd/network/10-ens3.network";
		restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  # don't update this
  system.stateVersion = "23.11";

  systemd.network.enable = true;
  services.resolved.enable = true;
  # services.resolved = {
	 #  enable = true;
	 #  fallbackDns = ["1.1.1.1" "1.0.0.1"];
  # };

  users = {
    mutableUsers = false;
    users = {
		root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl9LJZ1yKITrHoPGRnqX5FvCmGcE7/a10BwDX52tUgU"];
		k3s.passwordFile = config.sops.secrets.k3s_user_password.path;
	};
  };
}
