{
  inputs,
  config,
  lib,
  ...
}: let
  diskName = "nvme1n1";
  diskConfig = {
    imports = [
      (import ../../modules/hardware/disks/btrfs-encrypted.nix {inherit diskName;})
    ];
  };

  hardware = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      ../../modules/hardware/nvidia.nix
      ../../modules/hardware/opengl.nix
    ];
  };
in {
  imports = [
    diskConfig
    hardware
    ../../profiles/pc.nix
    ../../modules/users/schwem.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod"];
      kernelModules = ["kvm-intel"];
    };
    supportedFilesystems = ["btrfs"];
    loader.systemd-boot = {
      enable = true;
      editor = false; # leaving true allows for root access to be gained via passing kernal param
    };
  };

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

  networking = {
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.getty.autologinUser = "schwem";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/home/schwem/.config/sops/age/keys.txt";

    # these are all user secrets. might be better to use home-manager but idgaf right now
    secrets = {
      "bw_email" = {
        owner = "schwem";
      };
      "moltres_key" = {
        key = "ssh_private_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/moltres";
        sopsFile = ./../moltres/secrets.yaml;
      };
      "ssh_config" = {
        mode = "0600";
        owner = "schwem";
        path = "/home/schwem/.ssh/config";
      };
      "zapados_key" = {
        key = "ssh_private_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/zapados";
        sopsFile = ./../zapados/secrets.yaml;
      };
    };
  };

  system.autoUpgrade = true;
  # don't update this
  system.stateVersion = "23.05";

  time.timeZone = "America/Detroit";

  users = {
    mutableUsers = true; # allow mutable users on non-servers
    # users.schwem.passwordFile = config.sops.secrets.schwem_user_password.path;
  };
}
