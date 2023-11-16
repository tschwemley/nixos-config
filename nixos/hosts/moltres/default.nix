{
  self,
  lib,
  ...
}: {
  imports = [
    ./disk-config.nix
    ../../modules/k3s
    ../../modules/services/keycloak.nix
    ../../modules/server.nix
    ../../modules/users/k3s.nix
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
  boot.kernelModules = ["kvm-amd"];

  boot.supportedFilesystems = ["btrfs"];
  boot.loader.grub = {
    devices = ["/dev/vda"];
    efiSupport = true;
    # efiInstallAsRemovable = true;
  };

  networking.hostName = "moltres";

  sops = {
    defaultSopsFile = ./moltres.yaml;
    age.sshKeyPaths = ./moltres.pub;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    # This will generate a new key if the key specified above does not exist
    age.generateKey = true;
  };

  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.11"; #nixos-unstable

  # users.users.root.openssh.authorizedKeys.keys = [ (builtins.readFile ./moltres.pub) ];
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl9LJZ1yKITrHoPGRnqX5FvCmGcE7/a10BwDX52tUgU tschwemley@schwembook"];
  users.mutableUsers = false;
}
