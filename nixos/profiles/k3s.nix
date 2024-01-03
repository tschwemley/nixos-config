{
  config,
  lib,
  pkgs,
  nodeIP,
  nodeName,
  diskName ? "/dev/vda",
  extraKernelModules ? [],
  role ? "agent",
  useGrub ? false,
  ...
}: let
  disk = import ../modules/hardware/disks/vm.nix {inherit diskName useGrub;};
  k3s = import ../modules/services/k3s {
    inherit config lib pkgs nodeIP nodeName role;
  };
in {
  imports = [
    disk
    k3s
    ./server.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["wireguard"] ++ extraKernelModules;
    supportedFilesystems = ["btrfs"];
  };

  networking.hostName = nodeName;
  networking.dhcpcd.enable = false;

  # These are the sops secrets required by every k3s node
  sops = {
    secrets = {
      wireguard_private = {
        mode = "0400";
        path = "/persist/wireguard/private";
        owner = config.users.users.systemd-network.name;
        group = config.users.users.systemd-network.group;
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  systemd.network.enable = true;
  services.resolved.enable = true;
}
