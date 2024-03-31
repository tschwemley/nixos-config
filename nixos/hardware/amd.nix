{pkgs, ...}: let
  rocmPkgs = with pkgs.rocmPackages; [
    clr
    clr.icd
  ];
  utilPkgs = with pkgs; [
    amdgpu_top
    pciutils
  ];
in {
  boot.initrd.kernelModules = ["amdgpu"];

  environment.systemPackages = utilPkgs;

  hardware.enableRedistributableFirmware = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = rocmPkgs;
  };

  nixpkgs.config.rocmSupport = true;
  services.xserver.videoDrivers = ["modesetting"];
}
