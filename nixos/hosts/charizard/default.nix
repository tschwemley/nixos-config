{
  self,
  lib,
  ...
}: let
  diskName = "/dev/nvme0n1";
  swapSize = "-34G";
in {
  imports = [
    (import ../modules/disks/btrfs-ephemeral.nix {inherit diskName swapSize;})
    self.nixos-hardware.nixosModules.common.cpu.intel
    self.nixos-hardware.nixosModules.common.gpu.nvidia
    self.nixos-hardware.nixosModules.common.pc.ssd
    ../modules/users/desktop.nix
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
    useDHCP = true;
  };

  # sops = {
  #   defaultSopsFile = ../../secrets/secrets.yaml;
  #   age.sshKeyPaths = ./moltres.pub;
  #   age.keyFile = "/var/lib/sops-nix/key.txt";
  #   # This will generate a new key if the key specified above does not exist
  #   age.generateKey = true;
  # };

  #TODO: change this after done testing sys config
  services.getty.autologinUser = "schwem";

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
  };
}
