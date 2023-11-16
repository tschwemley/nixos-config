{
  config,
  lib,
  ...
}: {
  #imports = [../modules/virtualisation/proxmox-image.nix];

  proxmox.qemuConf = {
    bios = "ovmf";
    cores = 2;
    diskSize = "32000";
    memory = 4096;
    name = config.networking.hostName;
  };

  fileSystems."/" = {
    device = lib.mkForce "/dev/sda2";
    # autoResize = true;
    fsType = lib.mkForce "btrfs";
  };
  fileSystems."/boot".device = lib.mkForce "/dev/sda1";

  # allow the vm to have it's network access set up immediately
  services.cloud-init.network.enable = true;
}
