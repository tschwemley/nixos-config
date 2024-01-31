{pkgs, ...}: {
  boot.initrd.kernelModules = ["amdgpu"];

  environment = {
    systemPackages = with pkgs; [
      amdgpu_top
      clblast
      clinfo
      rocmPackages.rocm-smi
      pciutils
    ];

    sessionVariables = {
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
      rocmPackages.clr
      rocmPackages.clr.icd
      rocmPackages.hipblas
      rocmPackages.rocblas
      # amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  services.xserver.videoDrivers = ["modesetting"];
}
