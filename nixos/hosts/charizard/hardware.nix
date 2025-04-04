{
  config,
  lib,
  ...
}: {
  imports = [
    ../../hardware/amd.nix
    ../../hardware/audio
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
