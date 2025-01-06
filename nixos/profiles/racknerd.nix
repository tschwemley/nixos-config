{
  imports = [
    ./server.nix
    (import ../hardware/disks/racknerd.nix "/dev/vda")
    (import ../system/boot/grub.nix "/dev/vda")
    (import ../system/boot/systemd.nix)
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];
}
