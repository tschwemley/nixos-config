{pkgs, ...}: {
  boot.initrd.kernelModules = ["amdgpu"];

  environment = {
    systemPackages = with pkgs; [clblast];
    variables.AMD_VULKANICD = "RADV";
  };

  hardware.enableRedistributableFirmware = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr
      rocmPackages.hipblas
      rocmPackages.rocblas
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  services.xserver.videoDrivers = ["modesetting"];

  systemd.tmpfiles.rules = [
    # "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];
}
