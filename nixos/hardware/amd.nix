{pkgs, ...}: {
  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";

      # TODO: probably don't need these... but we'll see
      #
      # ROCm/OpenCL for compute
      ROCR_VISIBLE_DEVICES = "1";
      HSA_OVERRIDE_GFX_VERSION = "11.0.0"; # RDNA3 (7900 XTX = GFX1100)
    };

    systemPackages = with pkgs; [
      amdgpu_top
      clinfo
      libva-utils
      rocmPackages.rocminfo
      vulkan-tools
    ];
  };

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # amdvlk
        libva
        rocmPackages.clr.icd
        rocmPackages.hipblas
        rocmPackages.rocblas
        vaapiVdpau
      ];
    };
  };

  nixpkgs = {
    config.rocmSupport = true;
    # overlays = [self.overlays.rocmPackages];
  };

  services.xserver.videoDrivers = ["modesetting"];

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
