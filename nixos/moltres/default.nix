{
  inputs,
  config,
  lib,
  ...
}: let
  hostName = "moltres";
  diskConfig = import ../modules/disks/btrfs-ephemeral.nix {
    diskName = "/dev/vda";
    swapSize = "-4G";
  };
  impermanence = import ../modules/system/impermanence.nix {inherit inputs;};
  user = import ../modules/users/server.nix {
    inherit config;
    userName = hostName;
  };
in {
  imports = [
    diskConfig
    impermanence
    user
    ../profiles/server.nix
    # ./wireguard.nix
    # ../services/k3s
    # ../services/keycloak.nix
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
    useDHCP = lib.mkDefault true;
  };

  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    # Specify machine secrets
    secrets = {
      user_password = {
        neededForUsers = true;
      };
    };
  };

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
    users = {
      root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl9LJZ1yKITrHoPGRnqX5FvCmGcE7/a10BwDX52tUgU"];
      ${hostName}.passwordFile = config.sops.secrets.user_password.path;
    };
  };
}
