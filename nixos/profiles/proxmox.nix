{
  config,
  modulesPath,
  bios ? "ovmf",
  cores ? 2,
  extraImports ? [],
  memory ? 4096,
  profile ? "default",
  ...
}:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-image.nix")
    (./. + "/${profile}.nix")
  ] ++ extraImports;

  proxmox.qemuConf = {
    inherit cores memory;
    name = config.networking.hostName;
  };
}
