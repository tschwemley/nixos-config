{pkgs, ...}: {
  boot.initrd.kernelModules = ["amdgpu"];

  environment = {
    systemPackages = with pkgs; [
      clblast
      clinfo
    ];

    sessionVariables = {
      # AMD_VULKANICD = "RADV";
      CLBlast_DIR = "${pkgs.clblast.outPath}/lib/cmake/CLBlast";
      ROCM_PATH = "/opt/rocm";
    };
  };

  hardware.enableRedistributableFirmware = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      # amdvlk
      rocmPackages.rocm-smi
      rocmPackages.clr
      rocmPackages.hipblas
      rocmPackages.rocblas
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  services.xserver.videoDrivers = ["modesetting"];

  # systemd.tmpfiles.rules = [
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  # ];
}
