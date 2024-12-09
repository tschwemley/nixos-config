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

  # TODO: evaluate if this is still necessary
  environment.sessionVariables.LIBVA_DRIVER_NAME = "vdpau";

  hardware.amdgpu.opencl.enable = true;
  nixpkgs.config.rocmSupport = true;
}
