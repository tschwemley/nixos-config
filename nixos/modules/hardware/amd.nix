{ pkgs, ... }: {
  # boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["modesetting"];

  environment.variables.AMD_VULKANICD = "RADV";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ 
      # amdvlkt 
      mesa_23 
      rocm-opencl-icd
    ];
  };
}
