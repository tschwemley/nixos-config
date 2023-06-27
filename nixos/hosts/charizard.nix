{
  inputs,
  lib,
  ...
}: let
  diskName = "/dev/nvme0n1";
  swapSize = "-34G";
in {
  imports = [
    (import ../hardware/disks/btrfs-ephemeral.nix {inherit diskName swapSize;})
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    ./profiles/pc.nix
	../users/schwem.nix
  ];

  boot = {
    supportedFilesystems = ["btrfs"];
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = ["/dev/nvme0n1"];
      };
    };
  };

  networking = {
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # sops = {
  #   defaultSopsFile = ../../secrets/secrets.yaml;
  #   age.sshKeyPaths = ./moltres.pub;
  #   age.keyFile = "/var/lib/sops-nix/key.txt";
  #   # This will generate a new key if the key specified above does not exist
  #   age.generateKey = true;

  # };

  services.getty.autologinUser = "schwem";

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
  };
}
