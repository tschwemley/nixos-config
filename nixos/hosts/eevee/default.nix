{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/vda";
  nodeName = "eevee";
  useGrub = true;
  wireguardIP = "10.0.0.4";

  boot = import ../../modules/system/grub-boot.nix {inherit diskName;};
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config diskName lib nodeName pkgs useGrub;
    nodeIP = wireguardIP;
    role = "agent";
  };
  user = import ../../modules/users/server.nix {inherit config;};
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.2/32" "10.0.0.3/32"];
        Endpoint = "wg.schwem.io:9918";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
      }
      {
        # zapados
        AllowedIPs = ["10.0.0.2/32"];
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
      }
      {
        # moltres
        AllowedIPs = ["10.0.0.3/32"];
        PublicKey = "FT9Gnx4Ond9RRRvEkVmabRkF6Cjlzaus29Bg8MbIKkk=";
      }
    ];
  };
in {
  imports = [
    boot
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
  };

  # eevee has issues with DHCP so disable and use systemd-networkd instead
  networking = {
    dhcpcd.enable = false;
    hostName = nodeName;
    firewall.allowedUDPPorts = [52000];
  };

  #TODO: change this on all servers
  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/root/.config/sops/age/keys.txt";

    # Specify machine secrets
    secrets = {
      root_password = {
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

      wireguard_vpn = {
        path = "/persist/wireguard/vpn.conf";
        owner = config.users.users.systemd-network.name;
        group = config.users.users.systemd-network.group;
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  systemd.network.enable = true;
  services.resolved.enable = true;

  # don't update this
  system.stateVersion = "23.05";
}
