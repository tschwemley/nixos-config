{
  lib,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  # TODO: I don't know if this is necessary using vdpau/libvdpau-va-gl. reassess
  /* environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "VDPAU";
    #LIBVA_DRIVER_NAME = "iHD";
  }; */
}
