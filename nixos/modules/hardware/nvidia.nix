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
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "VDPAU";
  };
}
