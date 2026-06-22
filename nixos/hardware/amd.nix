{
  lib,
  pkgs,
  ...
}:
{
  boot = {
    # initrd.kernelModules = [ "amdgpu" ];

    # NOTE:
    # REF: https://gist.github.com/danielrosehill/6a531b079906f160911a87dea50e1507
    kernelParams = [
      "amdgpu.abmlevel=4"
      "amdgpu.aspm=1"
      "amdgpu.dcdebugmask=0x20"
      "amdgpu.dc=1"
      "amdgpu.dcfeaturemask=0x2"
      "amdgpu.disp_priority=2"
      "amdgpu.gpu_recovery=1"
      "amdgpu.sg_display=0"

      # "amdgpu.dpm=-1"
      "amdgpu.exp_hw_support=1"
      "amdgpu.freesync_video=1"
      "amdgpu.runpm=0"

      "amdgpu.modeset=1"

    ];
  };

  environment.systemPackages = with pkgs; [
    gpu-viewer
    nvtopPackages.amd
    rocmPackages.rocminfo
  ];

  hardware = {
    amdgpu = {
      initrd.enable = lib.mkDefault true;
      opencl.enable = lib.mkDefault true;

      overdrive = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };
    };

    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = [ pkgs.rocmPackages.clr.icd ];
    };
  };

  # enable rocm support for all packages
  nixpkgs.config.rocmSupport = lib.mkDefault true;

  services.lact.enable = true;

  services.xserver.videoDrivers = lib.mkDefault [
    "modesetting"
    "amdgpu"
  ];

  # KERNEL=="card1", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"
  '';

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
          # you can add more as needed, e.g. miopen-hip, rocfft, rocsparse
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
}
