{
  config,
  lib,
  pkgs,
  ...
  # }: let
  #   disk = import ../../hardware/disks/btrfs-encrypted.nix "/dev/disk/by-id/nvme-SHPP41-2000GM_SJC4N477711104A4V-part1" "crypted";
  # disk = import ../../hardware/disks/btrfs-encrypted.nix "/dev/disk/by-id/nvme-SHPP41-2000GM_SJC4N477711104A4V-part1" "crypted";
  # in {
}: {
  imports = [
    (import ./disk.nix "nvme1n1" "crypted")
    (import ../../hardware/odyssey-ark.nix {
      inherit pkgs;
      output = "DP-1";
    })

    ../../hardware/amd.nix
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # when building don't use all of the cpu cores
  nix.settings.cores = 16;
  services.hardware.bolt.enable = true;
}
