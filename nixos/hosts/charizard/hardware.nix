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

  home-manager.users.schwem = {
    xdg.configFile."niri/output.kdl".text = /* kdl */ ''
      output "DP-1" {
      	mode "3840x2160@119.879997"
      	position x=0 y=0
      	scale 1
      	transform "normal"

      	variable-refresh-rate
      }

      output "HDMI-A-2" {
      	mode "2160x2880@60.000"
      	position x=3840 y=0
      	scale 1.5 
      	transform "normal"
      }
    '';
  };

  nix.settings = {
    cores = 16; # when building don't use all of the cpu cores
    max-jobs = 16;
  };
}
