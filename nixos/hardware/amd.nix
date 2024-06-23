{
  lib,
  pkgs,
  ...
}:
#let
#   rocmPkgs = with pkgs.rocmPackages; [
#     clr
#     clr.icd
#   ];
#   utilPkgs = with pkgs; [
#     amdgpu_top
#     pciutils
#   ];
# in
{
  #imports = [inputs.nixos-hardware.nixosModules.common-gpu-amd];
  boot.initrd.kernelModules = ["amdgpu"];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    pciutils
  ];

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };

    # this is necessary to load the amd driver in initrd
    enableRedistributableFirmware = true;
  };

  nixpkgs.config.rocmSupport = true;
  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];
}
