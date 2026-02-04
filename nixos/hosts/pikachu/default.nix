{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  networking = {
    imports = [
      ../../network/tailscale.nix
    ];
  };
  user = (import ../../system/users.nix { inherit self config pkgs; }).schwem;
in
{
  imports = [
    networking
    user

    ./hardware.nix
    ../../profiles/pc.nix
    ../../system/boot/systemd.nix
  ];

  # boot = {
  #   initrd = {
  #     availableKernelModules = [
  #       "xhci_pci"
  #       "thunderbolt"
  #       "nvme"
  #     ];
  #
  #     kernelModules = [
  #       "kvm-intel"
  #       # "snd_hda_scodec_cs35l41"
  #     ];
  #   };
  #
  #   # kernelParams = [
  #   #   # These options are needed for suspend to work,
  #   #   # otherwise the nvme will be mounted read-only on resume
  #   #   "pcie_aspm=off"
  #   #   "pcie_port_pm=off"
  #   #   "nvme_core.default_ps_max_latency_us=0"
  #   #   "mem_sleep_default=deep"
  #   # ];
  #
  #   # TODO: built-in speakers are a nightmare. Fix at some point.
  #   #
  #   # options snd-intel-dspcfg dsp_driver=1
  #   # extraModprobeConfig = ''
  #   #   options snd-intel-dspcfg dsp_driver=4
  #   #   options snd_hda_intel model=1043:12af
  #   # '';
  # };

  # TODO: uncomment or remove
  # hardware.sensor.iio.enable = true;

  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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
