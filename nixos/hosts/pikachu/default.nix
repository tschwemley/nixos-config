{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  boot = (import ../../system/boot.nix).systemd;
  disk = (import ../../hardware/disks).pikachu;
  hardware = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      inputs.nixos-hardware.nixosModules.common-gpu-intel
      inputs.nixos-hardware.nixosModules.common-gpu-nvidia
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      inputs.nixos-hardware.nixosModules.asus-battery
      ../../hardware/audio
    ];
  };
  networking = {
    imports = [
      ../../network/containers.nix
      ../../network/tailscale.nix
    ];
  };
  user = (import ../../system/users.nix {inherit self config pkgs;}).schwem;
in {
  imports = [
    boot
    disk
    hardware
    networking
    user
    ./secrets.nix
    ../../profiles/pc.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod"];
      kernelModules = ["kvm-intel"];
    };
    kernelPackages = pkgs.linuxPackages_6_8;
    supportedFilesystems = ["btrfs"];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      # Bus ID of the Intel GPU.
      intelBusId = "PCI:0:2:0";

      # Bus ID of the NVIDIA GPU.
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  networking = {
    hostName = "pikachu";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    wireless.enable = true;
  };

  services.getty.autologinUser = "schwem";

  system = {
    autoUpgrade.enable = true;

    # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
    stateVersion = "24.05";
  };

  # tailscaleUpFlags = [
  #   "--exit-node=100.84.59.97"
  #   "--exit-node-allow-lan-access=true"
  #   "--shields-up"
  # ];
  time.timeZone = "America/Detroit";

  users.mutableUsers = true; # allow mutable users on non-servers

  # laptop specific options
  environment.systemPackages = with pkgs; [
    sof-firmware
  ];
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
  ];
  services.asusd.enable = true;
  services.hardware.bolt.enable = true;
  services.xserver.libinput = {
    enable = true;
    touchpad.tapping = false;
  };
  services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
}
