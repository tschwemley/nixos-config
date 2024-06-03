{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  boot = (import ../../system/boot.nix).systemd;
  disk = (import ../../hardware/disks).charizard;
  hardware = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      inputs.nixos-hardware.nixosModules.common-pc
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      ../../hardware/amd.nix
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
      # ++ [ # TODO: put these and the other passthrough/iommu in options in their own module
      #     "vfio_pci"
      #     "vfio"
      #     "vfio_iommu_type1"
      #     # "vfio_virqfd" # NOTE: this should now be folded into vfio. Remove if working okay
      # ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = [
    #   "intel_iommu=on"
    #   # "iommu=pt" NOTE: append this if necessary to prevent device from being touched while passed thru
    # ];
  };

  networking = {
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.getty.autologinUser = "schwem";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.11";

  tailscaleUpFlags = [
    "--allow-stateful-filtering"
    "--exit-node=100.84.59.97"
    "--exit-node-allow-lan-access=true"
    "--shields-up"
    "--ssh"
  ];
  time.timeZone = "America/Detroit";

  users.mutableUsers = true; # allow mutable users on non-servers
}
