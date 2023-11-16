{
  self,
  lib,
  ...
}: 
let
	diskConfig = {
		imports = [
			  ../modules/disks/root-ephemeral.nix
			(import ../modules/disks/btrfs-ephemeral.nix {
			  diskName = "/dev/vda";
			  swapSize = "2G";
			})
			(import ../modules/disks/btrfs-block-storage.nix {diskName = "/dev/sda";})
		];
	};
in
{
  imports =
    [
	  diskConfig
      ../modules/k3s
      ../modules/services/keycloak.nix
      ../modules/server.nix
      ../modules/users/k3s.nix
    ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd"];
    supportedFilesystems = ["btrfs"];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        devices = ["/dev/vda"];
        # in case canTouchEfiVariables doesn't work
        # efiInstallAsRemovable = true;
      };
    };
  };

  networking = {
    hostName = "moltres";
    networkmanager.enable = false;
    useDHCP = false;

    interfaces.ens3 = {
      useDHCP = false;

      ipv4.addresses = [
        {
          address = "184.189.4.107";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = "107.189.4.1";
  };

  # sops = {
  #   defaultSopsFile = ../../secrets/secrets.yaml;
  #   age.sshKeyPaths = ./moltres.pub;
  #   age.keyFile = "/var/lib/sops-nix/key.txt";
  #   # This will generate a new key if the key specified above does not exist
  #   age.generateKey = true;
  # };

  #TODO: change this after done testing sys config
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
    users.root.openssh.authorizedKeys.keys = [(builtins.readFile ../../secrets/keys/moltres.pub)];
  };
  # users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl9LJZ1yKITrHoPGRnqX5FvCmGcE7/a10BwDX52tUgU tschwemley@schwembook"];
}
