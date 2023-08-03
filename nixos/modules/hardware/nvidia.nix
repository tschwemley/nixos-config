{
  lib,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # also enable support for 32 bit applications (e.g. wine)
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    # LIBVA_DRIVER_NAME = "vdpau";
  };
}
