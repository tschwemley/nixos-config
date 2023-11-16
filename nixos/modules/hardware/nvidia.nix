{
  inputs,
  lib,
  pkgs,
  ...
}: {
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    # TODO: read https://download.nvidia.com/XFree86/Linux-x86_64/396.51/README/nvidia-persistenced.html 
    # and determine if should set
    #nvidiaPersistenced = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # also enable support for 32 bit applications (e.g. wine)
    extraPackages = with pkgs; [
      vaapiVdpau
      nvidia-vaapi-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "vdpau";
    VDPAU_DRIVER = "nvidia";
  };

  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
}
