{
  lib,
  pkgs,
  ...
}: {
  # disable integrated graphics
  boot.kernelParams = ["module_blacklist=i915"];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
  };
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # also enable support for 32 bit applications (e.g. wine)
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER_NAME = "nvidia";
  };
}
