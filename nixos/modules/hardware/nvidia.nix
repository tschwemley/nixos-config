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
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "VDPAU";
    #LIBVA_DRIVER_NAME = "iHD";
  };
}
