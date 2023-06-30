{
  self,
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
    ../services/k3s
    ../services/keycloak.nix
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
        # efiSupport = false;
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = ["/dev/vda"];
      };
    };
  };

  #TODO: change this after done testing sys config
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
    users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl9LJZ1yKITrHoPGRnqX5FvCmGcE7/a10BwDX52tUgU user@host"];
  };
}
