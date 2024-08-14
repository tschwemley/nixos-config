storageDisk: let 
  boot = (import ../system/boot.nix).grub "/dev/vda";
  disk = (import ../hardware/disks/buyvm.nix storageDisk);
in {
  imports = [
    boot 
    disk 
    ./server.nix
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
}
