{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    (import ./disk.nix "nvme1n1" "crypted")

    # TODO: change name or split into two files
    ../../hardware/odyssey-ark.nix

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

    kernelModules = [
      "kvm-intel"
    ];
  };

  home-manager.sharedModules = [
    {
      programs.niri.settings.outputs = {
        DP-1 = {
          focus-at-startup = true;
          scale = 1.2;

          mode = {
            width = 3840;
            height = 2160;
            refresh = 120.0;
          };

          position = {
            x = 0;
            y = 0;
          };
        };

        DP-2 = {
          focus-at-startup = true;
          scale = 1.6;

          mode = {
            width = 2560;
            height = 2880;
            refresh = 60.0;
          };

          position = {
            x = 3200;
            y = 0;
          };
        };
      };
    }
  ];

  nix.settings = {
    cores = 16; # when building don't use all of the cpu cores
    max-jobs = 16;
  };
}
