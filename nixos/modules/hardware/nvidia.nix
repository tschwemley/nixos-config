{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # disable integrated graphics
  #boot.kernelParams = ["module_blacklist=i915"];

  #imports = [ inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime  ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # also enable support for 32 bit applications (e.g. wine)
    extraPackages = with pkgs; [
      vaapiVdpau
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
  };

  # # Enable Intel iGPU early in the boot process
  # boot.initrd.kernelModules = [ "i915" ];
  #
  # environment.systemPackages =
  #   # Running `nvidia-offload vlc` would run VLC with dGPU
  #   let nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  #     export __NV_PRIME_RENDER_OFFLOAD=1
  #     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #     export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #     export __VK_LAYER_NV_optimus=NVIDIA_only
  #
  #     exec "$@"
  #   '';
  #   in [ nvidia-offload ];
  #
  # hardware.nvidia = {
  #   # Drivers must be at verion 525 or newer
  #   package = config.boot.kernelPackages.nvidiaPackages.beta;
  #   prime   = {
  #     offload.enable = true;        # Enable PRIME offloading
  #     intelBusId     = "PCI:0:2:0"; # lspci | grep VGA | grep Intel
  #     nvidiaBusId    = "PCI:1:0:0"; # lspci | grep VGA | grep NVIDIA
  #   };
  # };
  #
  # home-manager.users.jupblb = { lib, pkgs, ... }: {
  #   # Overwrite steam.desktop shortcut so that is uses PRIME
  #   # offloading for Steam and all its games
  #   home.activation.steam = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     $DRY_RUN_CMD sed 's/^Exec=/&nvidia-offload /' \
  #       ${pkgs.steam}/share/applications/steam.desktop \
  #       > ~/.local/share/applications/steam.desktop
  #     $DRY_RUN_CMD chmod +x ~/.local/share/applications/steam.desktop
  #   '';
  # };
  #
  # services.xserver.videoDrivers = [ "nvidia" ];

}
