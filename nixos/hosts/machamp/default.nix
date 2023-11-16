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
  user = import ../../modules/users/server.nix {inherit config;};
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32"];
        Endpoint = "wg.schwem.io:9918";
        PersistentKeepalive = 25;
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
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
  # this fixes a 'restricted url' issue when building host configs
  nix.extraOptions = ''
    allowed-uris = https://git.sr.ht/
    # allowed-uris = https://github.com/ https://git.savannah.gnu.org/
  '';
  services.getty.autologinUser = "root";
  services.openssh.enable = true;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/persist/.age-keys.txt";
  };

  # don't update this
  system.stateVersion = "23.05";

  systemd.network.enable = true;
  services.resolved.enable = true;
}
