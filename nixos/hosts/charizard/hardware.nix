{
  config,
  lib,
  ...
}: {
  imports = [
    ../../hardware/amd.nix
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # when building don't use all of the cpu cores
  nix.settings.cores = 16;
  services.hardware.bolt.enable = true;
}
