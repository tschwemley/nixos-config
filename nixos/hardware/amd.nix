{
  inputs,
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
    loadInInitrd = true;
    opencl = true;
  };

  nixpkgs.config.rocmSupport = true;

  # this is necessary to load the amd driver in initrd (not included in nixos-hardware)
  hardware.enableRedistributableFirmware = true;
}
