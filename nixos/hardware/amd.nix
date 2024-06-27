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
    opencl.enable = true;
  };

  nixpkgs.config.rocmSupport = true;
}
