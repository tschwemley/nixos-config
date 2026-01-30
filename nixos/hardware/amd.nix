{
  lib,
  pkgs,
  ...
}:
{
  boot = {
    kernelModules = [ "amdgpu" ];

    kernelParams = [
      # enables dynamic power management
      "amdgpu.dpm=1"

      # TODO: possible flickering fix... check if this works by re-enabling game mode on Ark
      # "amdgpu.sg_display=0"

      # Sets the powerplay feature mask. default is `0xfffd7fff`, which allows adjusting the
      # clock, profile, and voltage values. Setting to 0xffffffff enables all features.
      # REF: https://wiki.nixos.org/wiki/AMD_GPU#Sporadic_Crashes
      "amdgpu.ppfeaturemask=0xfffd7fff"
    ];
  };

  hardware = {
    amdgpu = {
      initrd.enable = lib.mkDefault true;
      opencl.enable = lib.mkDefault true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = [ pkgs.rocmPackages.clr.icd ];
    };
  };

  # enable rocm support for all packages
  nixpkgs.config.rocmSupport = lib.mkDefault true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="manual"
  '';

  # environment = {
  #   systemPackages = with pkgs; [
  #     libva-utils
  #     gpu-viewer
  #     nvtopPackages.amd
  #     rocmPackages.rocminfo
  #   ];
  # };
}
