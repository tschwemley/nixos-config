{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];
    initrd.kernelModules = [];
    kernelModules = [];
    extraModulePackages = [];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9de45e18-29e7-4330-b5ab-8a272f87aa36";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/037aa88c-cca8-43eb-b60b-757c6045861a";}
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
