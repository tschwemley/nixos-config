{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      clinfo
      nvtopPackages.amd

      # rocmPackages.rocminfo

      gpu-viewer
      vulkan-tools
    ];

    # TODO: necessary?
    sessionVariables = {
      # LIBVA_DRIVER_NAME = "radeonsi";
      # VDPAU_DRIVER = "radeonsi";
    };
  };

  hardware = {
    amdgpu = {
      initrd.enable = lib.mkDefault true;
      opencl.enable = lib.mkDefault true;
      overdrive.enable = lib.mkDefault true;
    };

    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;

      extraPackages = with pkgs; [
        libva
      ];
    };
  };

  nixpkgs.config.rocmSupport = lib.mkDefault true;

  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  # ---
  # TODO: below is my original config. Delete if the above minimal config does what I need.
  # ---

  # environment = {
  #   sessionVariables = {
  #     LIBVA_DRIVER_NAME = "radeonsi";
  #     VDPAU_DRIVER = "radeonsi";
  #
  #     # TODO: probably don't need these... but we'll see
  #     #
  #     # ROCm/OpenCL for compute
  #     ROCR_VISIBLE_DEVICES = "1";
  #     HSA_OVERRIDE_GFX_VERSION = "11.0.0"; # RDNA3 (7900 XTX = GFX1100)
  #   };
  #
  #   systemPackages = with pkgs; [
  #     amdgpu_top
  #     clinfo
  #     libva-utils
  #     rocmPackages.rocminfo
  #     vulkan-tools
  #   ];
  #
  #   # Some games choose AMDVLK over RADV, which can cause noticeable performance issues. This
  #   # forces RADV
  #   variables.AMD_VULKAN_ICD = "RADV";
  # };
  #
  # hardware = {
  #   amdgpu = {
  #     initrd.enable = true;
  #     opencl.enable = true;
  #   };
  #
  #   graphics = {
  #     enable = true;
  #     enable32Bit = true;
  #     extraPackages = with pkgs; [
  #       amdvlk
  #       libva
  #       rocmPackages.clr.icd
  #       rocmPackages.hipblas
  #       rocmPackages.rocblas
  #       vaapiVdpau
  #     ];
  #   };
  # };
  #
  # nixpkgs.config.rocmSupport = true;
  #
  # services.xserver.videoDrivers = [
  #   "amdgpu"
  #   "modesetting"
  #
  # ];
  # systemd.tmpfiles.rules = let
  #   rocmEnv = pkgs.symlinkJoin {
  #     name = "rocm-combined";
  #     paths = with pkgs.rocmPackages; [
  #       rocblas
  #       hipblas
  #       clr
  #     ];
  #   };
  # in [
  #   "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  # ];
}
