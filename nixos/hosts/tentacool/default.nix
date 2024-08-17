{
  inputs,
  config,
  lib,
  ...
}: let
  partitions = import ../../hardware/disks/efi-partitions.nix;
  rootDisk = import ../../hardware/disks/ephemeral-root.nix "/dev/sda" partitions;
in {
  imports = [
    # hardware
    rootDisk
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel-kaby-lake
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    # system + profile
    ../../system/boot/systemd.nix
    ../../profiles/server.nix

    # server imports
    ../../server/jellyfin
  ];

  boot = {
    kernelParams = ["acpi_rev_override"];
    kernelModules = ["kvm-intel"];
  };

  hardware.nvidia.prime = {
    # Bus ID of the Intel GPU.
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU.
    nvidiaBusId = "PCI:1:0:0";
  };

  networking = {
    hostName = "tentacool";
    wireless = {
      enable = true;
      environmentFile = "/run/secrets/wireless.env";
      networks."Where the Wild Pings Are" = {
        psk = "@PSK_HOME@";
      };
      extraConfig = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel";
    };
  };

  services.thermald.enable = lib.mkDefault true;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
    secrets."wireless.env" = {};

    templates."20-wireless.network" = {
      group = config.users.users.systemd-network.group;
      owner = config.users.users.systemd-network.name;

      mode = "0444";
      path = "/etc/systemd/network/10-primary.network";

      content = ''
        [Match]
        Name=wlp3s0

        [Network]
        Address=${config.sops.placeholder.publicIP}/24
        DNS=194.242.2.2 2a07:e340::2

        [Route]
        Destination=0.0.0.0/0
        Gateway=${config.sops.placeholder.gateway}
      '';
    };
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
