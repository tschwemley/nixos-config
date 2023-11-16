{
  inputs,
  config,
  lib,
  pkgs,
  nodeIP,
  nodeName,
  clusterInit ? false,
  diskName ? "/dev/vda",
  enableImpermanence ? true,
  role ? "agent",
  useGrub ? false,
  ...
}: let
  disk = import ../modules/hardware/disks/vm.nix {inherit diskName useGrub;};
  impermanence =
    if enableImpermanence
    then
      import ../modules/system/impermanence.nix {
        inherit inputs;
        additionalFiles = [
          "/var/lib/rancher/k3s/server/token"
        ];
        additionalDirs =
          if nodeName == "eevee"
          then ["/etc/systemd/network"]
          else [];
      }
    else {};
  k3s = import ../modules/services/k3s {
    inherit config lib pkgs clusterInit nodeIP nodeName role;
  };
in {
  imports = [
    disk
    impermanence
    k3s
    ./server.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd" "wireguard"];
    supportedFilesystems = ["btrfs"];
  };

  networking.hostName = nodeName;

  # These are the sops secrets required by every k3s node
  sops = {
    secrets = {
      root_password = {
        mode = "0440";
        neededForUsers = true;
      };
      user_password = {
        mode = "0440";
        neededForUsers = true;
      };
      wireguard_private = {
        mode = "0644";
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
