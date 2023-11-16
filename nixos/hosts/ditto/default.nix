{
  inputs,
  config,
  lib,
  ...
}: let
  hardware = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      ../../modules/hardware/nvidia.nix
      ../../modules/hardware/opengl.nix
    ];
  };
in {
  imports = [
    hardware
    ../../profiles/pc.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod"];
      kernelModules = ["kvm-intel"];
    };
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        # devices = ["/dev/nvme0n1"];
      };
    };
  };

  # isoImage.isoName = lib.mkDefault "nixos.iso";

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
    hostName = "ditto";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.getty.autologinUser = "root";

  # sops = {
  #   defaultSopsFile = ./secrets.yaml;
  #   age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  #   age.keyFile = "/persist/.age-keys.txt";
  #
  #   # Specify machine secrets
  #   secrets = {
  #     schwem_user_password = {
  #       neededForUsers = true;
  #     };
  #   };
  # };
  #
  # don't update this
  system.stateVersion = "23.05";
}
