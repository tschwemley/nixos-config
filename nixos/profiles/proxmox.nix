{
  imports = [
    ./server.nix

    ../hardware/disks/proxmox.nix
    ../system/boot/systemd.nix
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
  ethDev = "ens18";
}
