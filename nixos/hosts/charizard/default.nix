{
  inputs,
  config,
  lib,
  ...
}: let
  diskConfig = import ../../modules/disks/btrfs-ephemeral.nix {
    diskName = "/dev/nvme1n1";
    swapSize = "-34Gib";
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
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = ["/dev/nvme0n1"];
      };
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

  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/persist/.age-keys.txt";

    # Specify machine secrets
    secrets = {
      schwem_user_password = {
        neededForUsers = true;
      };
    };
  };

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = true; # allow mutable users on non-servers
    users.schwem.passwordFile = config.sops.secrets.schwem_user_password.path;
  };
}
