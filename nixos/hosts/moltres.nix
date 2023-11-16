{
  self,
  lib,
  ...
}: let
  diskName = "/dev/vda";
in {
  imports = [
    (import ../modules/disks/btrfs-ephemeral.nix {inherit diskName;})
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
      grub = {
        # efiSupport = false;
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = ["/dev/vda"];
      };
    };
  };

  networking = {
    hostName = "moltres";
    networkmanager.enable = false;
    useDHCP = false;

    interfaces.eth0 = {
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

  #TODO: change this after done testing sys config
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
	users.root.openssh.authorizedKeys.keys = [builtins.readFile ../../secrets/keys/moltres.pub];
  };
}
