{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  nodeName = "eevee";
  useGrub = true;
  wireguardIP = "10.0.0.4";

  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib nodeName pkgs useGrub;
    clusterInit = true;
    nodeIP = wireguardIP;
    role = "server";
  };
  user = import ../../modules/users/server.nix {
    inherit config;
    userName = nodeName;
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
      }
    ];
  };
in {
  imports = [
    k3s
    user
    wireguard
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
    hostname = nodeName;
    dhcpcd.enable = false;
  };

  #TODO: change this on all servers
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

  users = {
    mutableUsers = false;
    users = {
      root = {
        passwordFile = config.sops.secrets.root_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
      ${nodeName} = {
        passwordFile = config.sops.secrets.user_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
    };
  };
}
