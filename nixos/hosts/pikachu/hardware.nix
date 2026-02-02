{
  inputs,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    (import ./disk.nix "nvme0n1" "pika-crypted")

    "${inputs.nixos-hardware}/common/cpu/intel/alder-lake"
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.asus-battery
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
      ];
    };

    kernelModules = [
      "kvm-intel"
      "snd_hda_intel"
      "sof_audio_pci_intel_tgl"
    ];
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];

  hardware = {
    asus.battery = {
      chargeUpto = 90;
      enableChargeUptoScript = true;
    };

    # firmware = [ pkgs.sof-firmware ];

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      # enabled = lib.mkForce true; # NOTE: Can't define this apparently... already set

      dynamicBoost.enable = true;
      gsp.enable = true;
      modesetting.enable = true;
      nvidiaPersistenced = true;
      nvidiaSettings = true;
      open = false;
      videoAcceleration = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        # Bus ID of the Intel GPU.
        intelBusId = "PCI:0:2:0";

        # Bus ID of the NVIDIA GPU.
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    nvidia-container-toolkit.enable = true;
  };

  # when building don't use all of the cpu cores
  nix.settings = {
    # TODO: make sure this matches the cpu cores for pikachu
    cores = 8; # when building don't use all of the cpu cores
    max-jobs = 8;
  };

  # declare support for derivations requiring nvidia gpu available
  programs.nix-required-mounts.presets.nvidia-gpu.enable = true;

  services.hardware.bolt.enable = true;
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };
}
