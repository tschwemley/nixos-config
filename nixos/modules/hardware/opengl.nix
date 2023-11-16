{
  hardware.opengl.enable = true;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "VDPAU";
    #LIBVA_DRIVER_NAME = "iHD";
  };
}
# TODO: remove below if no issues
/*
{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # TODO: remove if unneeded
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
*/

