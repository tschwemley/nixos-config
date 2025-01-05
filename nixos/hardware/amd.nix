{
  inputs,
  pkgs,
  ...
}: {
  # hardware.amdgpu.initrd, hardware.graphics, and services.xserver.videoDrivers are all set in nixos-hardware
  imports = [inputs.nixos-hardware.nixosModules.common-gpu-amd];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    glxinfo
    pciutils
    vulkan-tools
  ];

  hardware.amdgpu.opencl.enable = true;
  nixpkgs.config.rocmSupport = true;
}
