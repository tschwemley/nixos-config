{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  hostName = "eevee";
  diskConfig = import ../../modules/hardware/disks/k3s.nix {diskName = "/dev/vda";};
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib pkgs;
    nodeIP = "10.0.0.4";
    role = "agent";
  };
  user = import ../../modules/users/server.nix {
    inherit config;
    userName = hostName;
  };
in {
  imports = [
    diskConfig
    user
    ../../profiles/default.nix
    ./wireguard.nix
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

  # eevee has issues with DHCP so disable and use systemd-networkd instead
  networking = {
    inherit hostName;
    dhcpcd.enable = false;
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
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/persist/.age-keys.txt";

    # Specify machine secrets
    secrets = {
      root_password = {
        neededForUsers = true;
      };
      user_password = {
        neededForUsers = true;
      };
      systemd_networkd_10_ens3 = {
        mode = "0644";
        path = "/etc/systemd/network/10-ens3.network";
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
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

  # enable systemd-networkd for this machine
  systemd.network.enable = true;
  services.resolved.enable = true;

  users = {
    mutableUsers = false;
    users = {
      root = {
        passwordFile = config.sops.secrets.root_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
      ${hostName} = {
        passwordFile = config.sops.secrets.user_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
    };
  };
}
