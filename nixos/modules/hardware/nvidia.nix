{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # disable integrated graphics
  #boot.kernelParams = ["module_blacklist=i915"];

  imports = [ inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime  ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # also enable support for 32 bit applications (e.g. wine)
    extraPackages = with pkgs; [
      vaapiVdpau
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
  };
}
