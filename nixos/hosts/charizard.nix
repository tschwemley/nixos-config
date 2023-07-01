{
  inputs,
  lib,
  ...
}: let
  diskConfig = import ../hardware/disks/btrfs-ephemeral.nix {
    diskName = "/dev/nvme0n1";
    swapSize = "-34G";
  };
in {
  imports = [
    diskConfig
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    ./profiles/pc.nix
    ../users/schwem.nix
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

  networking = {
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.getty.autologinUser = "schwem";

  # don't update this
  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
  };
}
