{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  disk = (import ../../hardware/disks).charizard;
  hardware = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      ../../hardware/amd.nix
      ../../hardware/audio
    ];
  };
  networking = {
    imports = [
      ../../network/containers.nix
      ../../network/systemd-networkd.nix
      ../../network/tailscale.nix
    ];
  };
  ollama = import ../../../containers/ollama "/home/schwem/.ollama";
  sillytavern = import ../../../containers/sillytavern "/home/schwem/.sillytavern";
  user = (import ../../system/users.nix {inherit self config pkgs;}).schwem;
in {
  imports = [
    disk
    hardware
    networking
    ollama
    sillytavern
    user
    ./secrets.nix
    ../../system/boot/systemd.nix
    ../../services/samba.nix
    ../../profiles/pc.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod"];
      kernelModules = ["amdgpu" "kvm-intel"];
    };
    # TODO: remove this or uncomment after I decide whether I want to be on the latest kernel or on LTS
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  ethDev = "enp6s0";

  networking = {
    hostName = "charizard";
    wireless.enable = true;
  };

  services.getty.autologinUser = "schwem";
  services.resolved.dnsovertls = lib.mkDefault "true";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.05";

  tailscaleUpFlags = [
    "--exit-node=100.84.59.97"
    "--exit-node-allow-lan-access=true"
    "--shields-up"
    "--ssh"
  ];
  time.timeZone = "America/Detroit";

  users.mutableUsers = true; # allow mutable users on non-servers

  home-manager.users.schwem.hyprland.monitors = [
      # "HDMI-A-2,3840x2160@120,0x0,1" # LG C2
      # "DP-2,2560x2880@60,3840x0,1" # LG Dual Up
      "DP-1,5120x3440@240,0x0,1" # Odyssey g9
  ];
}
