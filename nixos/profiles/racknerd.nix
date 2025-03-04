# {modulesPath, ...}: let
let
  primaryDisk = "/dev/vda";
  partitions = import ../hardware/disks/partitions.nix;
in {
  imports = [
    ./server.nix

    (import ../system/boot/grub.nix primaryDisk)
    (import ../hardware/disks/ephemeral-root.nix primaryDisk partitions.grubEfi)
    ../hardware/disks/swap.nix
    # (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  # top list equivalent of (modulesPath + "/profiles/qemu-guest.nix")
  boot.initrd.availableKernelModules =
    [
      "virtio_net"
      "virtio_pci"
      "virtio_mmio"
      "virtio_blk"
      "virtio_scsi"
      "9p"
      "9pnet_virtio"
    ]
    ++
    # this bottom list is from nixos-generate-config
    ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];

  boot.initrd.kernelModules = [
    "virtio_balloon"
    "virtio_console"
    "virtio_rng"
    "virtio_gpu"
  ];
}
