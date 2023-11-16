{
  self,
  config,
  lib,
  ...
}: let
  hostName = "zapados";
  diskConfig = import ../modules/hardware/disks/btrfs-ephemeral.nix {
    diskName = "/dev/vda";
    swapSize = "-6G";
  };
in {
  imports = [
    diskConfig
    ../profiles/server.nix
    # ../services/k3s
    # ../services/keycloak.nix
    # ../modules/users/k3s.nix
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

  networking = {
	  inherit hostName;
	  dhcpcd.enable = false;
  };

  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    secrets = {
	  root_password = {
		 neededForUsers = true; 
	  };
	  user_password = {
		 neededForUsers = true; 
	  };
	  # static ip config via systemd.networkd is stored via sops and symlinked to appropriate directory
      systemd_networkd_10_ens3 = {
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

  users = {
    mutableUsers = false;
    users = {
		# root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl9LJZ1yKITrHoPGRnqX5FvCmGcE7/a10BwDX52tUgU"];
		root = {
			openssh.authorizedKeys.keys = [];
			passwordFile = config.sops.secrets.root_password.path;	
		};
		${hostName}.passwordFile = config.sops.secrets.user_password.path;
	};
  };
}
