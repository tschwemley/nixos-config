{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (import ./disk.nix "nvme0n1" "pika-crypted")

    "${inputs.nixos-hardware}/common/cpu/intel/alder-lake"
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.asus-battery
  ];

  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];

  hardware = {
    firmware = [pkgs.sof-firmware];

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      # NOTE: Can't define this apparently... already set
      # enabled = lib.mkForce true;
      dynamicBoost.enable = true;
      gsp.enable = true;
      modesetting.enable = true;
      nvidiaPersistenced = true;
      nvidiaSettings = true;
      # TODO: open preferred theoretically but I'm not sure when it comes to CUDA
      # open = true;true
      open = false;
      # package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.stable;
      videoAcceleration = true;

      prime = {
        # Bus ID of the Intel GPU.
        intelBusId = "PCI:0:2:0";

        # Bus ID of the NVIDIA GPU.
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    nvidia-container-toolkit.enable = true;
  };

  # when building don't use all of the cpu cores
  nix.settings.cores = 16;

  # declare support for derivations requiring nvidia gpu available
  programs.nix-required-mounts.presets.nvidia-gpu.enable = true;

  services.hardware.bolt.enable = true;
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];

  systemd.services.nvidia-control-devices = {
    wantedBy = ["multi-user.target"];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };
}
