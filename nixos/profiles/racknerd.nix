{modulesPath, ...}: let
  diskName = "/dev/vda";
  partitions = import ../hardware/disks/grub-partition.nix // import ../hardware/disks/efi-partitions.nix;
in {
  imports = [
    ./server.nix

    (import ../hardware/disks/ephemeral-root.nix diskName partitions)
    (import ../system/boot/grub.nix "/dev/vda")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];
}
