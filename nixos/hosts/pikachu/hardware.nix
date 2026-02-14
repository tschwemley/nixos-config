{
  inputs,
  config,
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

    ./ux582_cirrus_patch
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
      ];
    };

    loader.efi.canTouchEfiVariables = true;

    kernelModules = [ "kvm-intel" ];

    kernelParams = [
      # These options are needed for suspend to work,
      # otherwise the nvme will be mounted read-only on resume
      "pcie_aspm=off"
      "pcie_port_pm=off"
      "nvme_core.default_ps_max_latency_us=0"
      "mem_sleep_default=deep"
    ];
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    nvtopPackages.nvidia
  ];

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    asus.battery = {
      chargeUpto = 90;
      enableChargeUptoScript = true;
    };

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

        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
    };

    nvidia-container-toolkit.enable = true;

    sensor.iio.enable = true;
  };

  home-manager.users.schwem = {
    xdg.configFile."niri/output.kdl".text = /* kdl */ ''
      output "eDP-1" {
        focus-at-startup
      	mode "3840x2160@60.000"
      	position x=0 y=0
      	scale 1.75
      	transform "normal"
      }

      output "DP-1" {
      	mode "3840x1100@60"
      	position x=0 y=1234
      	scale 1.75
      	transform "normal"
      }
    '';
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
