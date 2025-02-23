{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    amdgpu_top
    glxinfo
    pciutils
    vulkan-tools
  ];

  hardware = {
    amdgpu = {
      initrd.enable = lib.mkDefault true;
      opencl.enable = true;
    };

    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };
  };

  nixpkgs.config.rocmSupport = true;
  services.xserver.videoDrivers = lib.mkDefault ["modesetting"];

  # Most software has the HIP libraries hard-coded. You can work around it on NixOS by using:
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];
}
