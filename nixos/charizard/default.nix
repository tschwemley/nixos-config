{
  inputs,
  config,
  lib,
  ...
}: let
  diskConfig = import ../modules/disks/btrfs-ephemeral.nix {
    diskName = "/dev/nvme0n1";
    swapSize = "-34G";
  };
  hardware = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    ];
  };
in {
  imports = [
    diskConfig
    hardware
    ../profiles/pc.nix
    ../modules/users/schwem.nix
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
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    hostKeys = [
      {
        bits = 4096;
        path = "/persist/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
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
    age.sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
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
    mutableUsers = false;
    users.schwem.passwordFile = config.sops.secrets.schwem_user_password.path;
  };
}
