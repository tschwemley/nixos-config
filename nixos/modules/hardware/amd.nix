{ pkgs, ... }: {
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["modesetting"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
# extraPackages = with pkgs; [ amdvlkt ];
  };
}
