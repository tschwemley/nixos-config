{
  inputs,
  config,
  lib,
  ...
}: let
  hostName = "zapados";
  diskConfig = import ../modules/disks/btrfs-ephemeral.nix {
    diskName = "/dev/vda";
    swapSize = "-6G";
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
    ./wireguard.nix
    # ../services/k3s
    # ../services/keycloak.nix
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
        devices = ["/dev/vda"];
      };
    };
  };

  networking = {
    inherit hostName;
    useDHCP = lib.mkDefault true;
  };

  services.getty.autologinUser = "root";

  services.openssh = {
    enable = true;
    # PasswordAuthentication = false;
    # KbdInteractiveAuthentication = false;
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [
      "/persist/etc/ssh/ssh_host_ed25519_key"
    ];
    age.keyFile = "/persist/.age-keys.txt";

    secrets = {
      root_password = {
        neededForUsers = true;
      };
      user_password = {
        neededForUsers = true;
      };
      wireguard_private = {
		mode = "0644";
        path = "/persist/wireguard/private";
        reloadUnits = ["systemd-networkd" "systemd-resolved"];
      };
      wireguard_public = {
        #this doesn't need to be a secret but it's convenient
        path = "/persist/wireguard/public";
      };
    };
  };

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
    users = {
      root = {
        openssh.authorizedKeys.keys = [];
        passwordFile = config.sops.secrets.root_password.path;
      };
      ${hostName}.passwordFile = config.sops.secrets.user_password.path;
    };
  };
}
