{
  config,
  lib,
  ...
}: {
  proxmox = {
    qemuConf = {
      boot = "order=scsci0;ide2;net0";
      bios = "ovmf";
      cores = 2;
      diskSize = "32000";
      memory = 4096;
      name = config.networking.hostName;
      scsihw = "virtio-scsi-single";
    };
    qemuExtraConf = {
      # ide2 = "local:iso/nixos-minimal-23.05.2422.391e8db1f06-x86_64-linux.iso,media=cdrom,size=818M";
    };
  };

  fileSystems."/" = {
    device = lib.mkForce "/dev/sda2";
    fsType = lib.mkForce "btrfs";
  };
  fileSystems."/boot".device = lib.mkForce "/dev/sda1";

  # allow the vm to have it's network access set up immediately
  services.cloud-init.network.enable = true;
}
