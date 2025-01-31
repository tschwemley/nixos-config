{modulesPath, ...}: let
  primaryDisk = "/dev/vda";
  partitions = import ../hardware/disks/partitions.nix;
in {
  imports = [
    ./server.nix

    (import ../hardware/disks/ephemeral-root.nix primaryDisk partitions.grubEfi)
    (import ../system/boot/grub.nix primaryDisk)
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];
}
