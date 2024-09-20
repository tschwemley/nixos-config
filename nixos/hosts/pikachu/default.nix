{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
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
  user = (import ../../system/users.nix { inherit self config pkgs; }).schwem;
in
{
  imports = [
    disk
    hardware
    networking
    user
    ./secrets.nix
    ../../system/boot/systemd.nix
    ../../profiles/pc.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      kernelModules = [ "kvm-intel" ];
    };
    # TODO: this might need to be latest for laptop config. not sure yet
    kernelPackages = pkgs.linuxPackages_6_10;
    supportedFilesystems = [ "btrfs" ];

    blacklistedKernelModules = [
      "snd_soc_avs"
    ];

    extraModprobeConfig = ''
      # options snd-intel-dspcfg dsp_driver=1
      options snd-intel-dspcfg dsp_driver=3
      options snd_sof_pci ipc_type=1
      # options snd_sof_intel_hda_common sof_use_tplg_nhlt=1
    '';
  };

  networking = {
    hostName = "pikachu";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    wireless.enable = true;
  };

  system = {
    autoUpgrade.enable = true;

    # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
    stateVersion = "24.05";
  };

  services.tailscale.extraUpFlags = [
    "--exit-node=100.84.59.97"
    "--exit-node-allow-lan-access=true"
    "--shields-up"
  ];
  time.timeZone = "America/Detroit";

  users.mutableUsers = true; # allow mutable users on non-servers

  home-manager.users.schwem.hyprland = {
    monitors = {
      primary = "eDP-1";
      config = [
        "eDP-1,3840x2160@60,0x0,1.5"
        "DP-1,3840x1100@120,0x1080,1.67"
      ];
    };
    workspaces = [
      "1, monitor:eDP-1"
      "2, monitor:eDP-1"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5, monitor:DP-1"
      "6, monitor:DP-1"
      "7, monitor:DP-1"
      "8, monitor:DP-1"
    ];
  };

  # laptop specific options
  environment.systemPackages = with pkgs; [
    sof-firmware
  ];

  hardware = {
    nvidia = {
      open = lib.mkDefault true;
      prime = {
        # Bus ID of the Intel GPU.
        intelBusId = "PCI:0:2:0";

        # Bus ID of the NVIDIA GPU.
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    opengl.enable = true;
    opengl.extraPackages = with pkgs; [
      vaapiVdpau
    ];
  };

  services = {
    asusd.enable = true;
    hardware.bolt.enable = true;
    libinput = {
      enable = true;
      touchpad.tapping = false;
    };
    xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
  };
}
