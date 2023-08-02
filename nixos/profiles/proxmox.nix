{
  config,
  modulesPath,
  bios ? "ovmf",
  cores ? 2,
  diskSize ? "32000",
  memory ? 4096,
  ...
}: {
  imports = [../modules/virtualisation/proxmox-image.nix];

  proxmox.qemuConf = {
    inherit bios cores diskSize memory;
    name = config.networking.hostName;
  };

  # allow the vm to have it's network access set up immediately
  services.cloud-init.network.enable = true;
}
