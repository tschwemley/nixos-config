{
  inputs,
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
  imports = [inputs.nixos-hardware.nixosModules.common-gpu-amd];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    pciutils
  ];

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };

  nixpkgs.config.rocmSupport = true;
  services.xserver.videoDrivers = lib.mkDefault ["modesetting"];
}
