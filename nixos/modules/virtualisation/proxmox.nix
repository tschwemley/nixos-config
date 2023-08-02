{
  config,
  modulesPath,
  bios ? "ovmf",
  cores ? 2,
  memory ? 4096,
  ...
}: {
  imports = [./proxmox-image.nix];

  proxmox.qemuConf = {
    inherit bios cores memory;
    name = config.networking.hostName;
  };
}
