{
  config,
  lib,
  ...
}: {
  imports = [
    ../../hardware/amd.nix
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
