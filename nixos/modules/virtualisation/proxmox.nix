{
  config,
  modulesPath,
  bios ? "ovmf",
  cores ? 2,
  memory ? 4096,
  ...
}: {
  imports = [(modulesPath + "/virtualisation/proxmox-image.nix")];

  proxmox.qemuConf = {
    inherit bios cores memory;
    name = config.networking.hostName;
  };
}
