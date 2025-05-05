{
  inputs,
  config,
  ...
}: {
  imports = [
    "${inputs.nixos-hardware}/common/cpu/intel/alder-lake"
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.asus-battery
  ];

  # TODO: necessary?
  # expliticly disable proprietary kernel modules
  # boot.blacklistedKernelModules = [
  #   "nvidia"
  #   "nvidiafb"
  #   "nvidia-drm"
  #   "nvidia-uvm"
  #   "nvidia-modeset"
  # ];

  hardware.nvidia = {
    # enabled = lib.mkDefault true;
    dynamicBoost.enable = true;
    gsp.enable = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    videoAcceleration = true;

    prime = {
      # Bus ID of the Intel GPU.
      intelBusId = "PCI:0:2:0";

      # Bus ID of the NVIDIA GPU.
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
}
