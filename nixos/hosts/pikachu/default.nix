{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  networking = {
    imports = [
      ../../network/tailscale.nix
    ];
  };
  user = (import ../../system/users.nix {inherit self config pkgs;}).schwem;
in {
  imports = [
    networking
    user

    ./hardware.nix
    ../../profiles/pc.nix
    ../../system/boot/systemd.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
      ];

      kernelModules = [
        "kvm-intel"
        "snd_hda_scodec_cs35l41"
      ];
    };

    kernelParams = [
      # These options are needed for suspend to work,
      # otherwise the nvme will be mounted read-only on resume
      "pcie_aspm=off"
      "pcie_port_pm=off"
      "nvme_core.default_ps_max_latency_us=0"
      "mem_sleep_default=deep"
    ];

    # TODO: built-in speakers are a nightmare. Fix at some point.
    #
    # options snd-intel-dspcfg dsp_driver=1
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=4
      options snd_hda_intel model=1043:12af
    '';
  };

  # TODO: uncomment or remove
  # hardware.sensor.iio.enable = true;

  networking = {
    hostName = "pikachu";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  system = {
    autoUpgrade.enable = true;

    # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
    stateVersion = "24.05";
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  home-manager.users.schwem.hyprland = {
    monitors = {
      primary = "eDP-1";
      config = [
        "eDP-1,3840x2160@60,0x0,1.5"
        "DP-1,3840x1100@120,0x1440,1.67"
      ];
    };
    workspaces = [
      "1, monitor:eDP-1"
      "2, monitor:eDP-1"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5, monitor:DP-1"
    ];
  };

  home-manager.users.schwem.wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod, 5, workspace, 5"
      "$mod shift, 5, movetoworkspace, 5"
    ];

    input = {
      kboptions = "shift:nocaps";
    };
  };

  # laptop specific options
  environment.systemPackages = with pkgs; [
    asusctl
    supergfxctl

    # acpi
    # acpidump-all
    # sof-firmware
  ];

  services = {
    asusd.enable = true;

    libinput = {
      enable = true;
      touchpad.tapping = false;
    };

    thermald.enable = lib.mkDefault true;
  };
}
