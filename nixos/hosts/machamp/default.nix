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
    userSSHKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtX7rD2rPRB1L+/CuPYZ7uCbLzezgBpoUcHAW6ZP5yu *";
  };
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32"];
        Endpoint = "wg.schwem.io:9918";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
        PersistentKeepAlive = 25;
      }
    ];
  };
in {
  imports = [
    disk
    profile
    user
    wireguard
    ./nginx.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd" "wireguard"];
    supportedFilesystems = ["btrfs"];
    loader.systemd-boot = {
      enable = true;
      editor = false; # leaving true allows for root access to be gained via passing kernal param
    };
  };

  networking.hostName = hostName;
  services.getty.autologinUser = "root";
  services.openssh.enable = true;
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/persist/.age-keys.txt";

    secrets = {
      wireguard_private = {
        mode = "0644";
        path = "/persist/wireguard/private";
        owner = config.users.users.systemd-network.name;
        group = config.users.users.systemd-network.group;
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  # don't update this
  system.stateVersion = "23.05";

  systemd.network.enable = true;
  services.resolved.enable = true;
}
