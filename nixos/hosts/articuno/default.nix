{
  inputs,
  config,
  lib,
  modulesPath,
  ...
}: let
  hostName = "articuno";

  impermanence = import ../../modules/system/impermanence.nix {inherit inputs;};

  user = import ../../modules/users/server.nix {
    inherit config;
    userName = hostName;
  };
in {
  imports = [
#(modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/virtualisation/proxmox-image.nix")
    impermanence
    user
    ../../profiles/default.nix
    # ./wireguard.nix
    # ../../modules/services/k3s/server.nix
    # ../../profiles/k3s.nix
  ];

  # boot = {
  #   # supportedFilesystems = ["btrfs"];
  #   loader = {
  #     systemd-boot.enable = true;
  #     efi.canTouchEfiVariables = true;
  #   };
  # };

  networking = {
    inherit hostName;
    dhcpcd.enable = false;
  };

  services.getty.autologinUser = "root";

  services.openssh = {
    enable = true;
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

  # sops = {
  #   defaultSopsFile = ./secrets.yaml;
  #   age.sshKeyPaths = [
  #     "/persist/etc/ssh/ssh_host_ed25519_key"
  #   ];
  #   age.keyFile = "/persist/.age-keys.txt";
  #
  #   secrets = {
  #     root_password = {
  #       neededForUsers = true;
  #     };
  #     user_password = {
  #       neededForUsers = true;
  #     };
  #     systemd_networkd_10_ens3 = {
  #       mode = "0644";
  #       path = "/etc/systemd/network/10-ens3.network";
  #       restartUnits = ["systemd-networkd" "systemd-resolved"];
  #     };
  #     wireguard_private = {
  #       mode = "0644";
  #       path = "/persist/wireguard/private";
  #       owner = config.users.users.systemd-network.name;
  #       group = config.users.users.systemd-network.group;
  #       restartUnits = ["systemd-networkd" "systemd-resolved"];
  #     };
  #   };
  # };

  # don't update this
  system.stateVersion = "23.05";
  # systemd.network.enable = true;
  # services.resolved.enable = true;

  # users = {
  #   mutableUsers = false;
  #   users = {
  #     root = {
  #       passwordFile = config.sops.secrets.root_password.path;
  #       openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
  #     };
  #     ${hostName} = {
  #       passwordFile = config.sops.secrets.user_password.path;
  #       openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
  #     };
  #   };
  # };
}
