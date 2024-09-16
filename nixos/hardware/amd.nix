{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixos-hardware.nixosModules.common-gpu-amd ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    pciutils
  ];

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };

  nixpkgs.config.rocmSupport = true;
  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];
}
