{pkgs, ...}: {
  boot.initrd.kernelModules = ["amdgpu"];
  environment.variables.AMD_VULKANICD = "RADV";
  hardware.enableRedistributableFirmware = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  # services.xserver.videoDrivers = ["modesetting"];
  services.xserver.videoDrivers = ["amdgpu"];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];
}
