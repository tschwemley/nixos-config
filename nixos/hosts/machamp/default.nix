{
  inputs,
  config,
  modulesPath,
  ...
}: let
  diskName = "/dev/sda";
  hostName = "machamp";
  wireguardIP = "10.0.0.99";

  disk = import ../../modules/hardware/disks/vm.nix {inherit diskName;};
  profile = import ../../profiles/hydra.nix;
  user = import ../../modules/users/server.nix {
    inherit config;
    userName = hostName;
  };
  # wireguard = import ../../modules/networking/wireguard.nix {
  #   inherit config;
  #   ip = wireguardIP;
  #   peers = [
  #     {
  #       # articuno
  #       PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
  #       AllowedIPs = ["10.0.0.1/32"];
  #     }
  #   ];
  # };
in {
  imports = [
    disk
    profile
    user
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd" "wireguard"];
    supportedFilesystems = ["btrfs"];
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = ["/dev/sda"];
      };
    };
  };

  networking.hostName = hostName;
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.05";
}
