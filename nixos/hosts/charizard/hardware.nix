{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    # inputs.nixos-hardware.nixosModules.common-gpu-amd
    (import ./disk.nix "nvme1n1" "crypted")

    (import ../../hardware/odyssey-ark.nix {
      inherit lib pkgs;
      output = "DP-1";
      # output = "HDMI-A-2";
    })

    ../../hardware/amd.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "usbhid"
        "xhci_pci"
      ];
    };

    kernelModules = [ "kvm-intel" ];
  };

  nix.settings = {
    cores = 16; # when building don't use all of the cpu cores
    max-jobs = 16;
  };
}
