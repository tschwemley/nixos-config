{ pkgs, ... }: {
  services.xserver.videoDrivers = ["modesetting"];
  environment.variables.AMD_VULKANICD = "RADV";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ 
      # amdvlkt 
      rocm-opencl-icd
    ];
  };
}
