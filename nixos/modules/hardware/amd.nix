{ pkgs, ... }: {
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
#extraPackages = with pkgs; [ amdvlk ];
  };
}
