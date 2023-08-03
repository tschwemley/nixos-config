{
  lib,
  pkgs,
  ...
}: {
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # also enable support for 32 bit applications (e.g. wine)
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    #LIBVA_DRIVER_NAME = "nvidia";
    # LIBVA_DRIVER_NAME = "vdpau";
  };
}
