{
  self,
  ...
}:
{
  imports = [
    self.inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
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

  home-manager.users.schwem = {
    wayland.windowManager.niri.settings._children = [
      {
        output = {
          _args = [ "DP-1" ];

          focus-at-startup = { };
          mode = "3840x2160@120.000";
          # mode = "3840x2160@164.991";
          scale = 1.20;
          transform = "normal";

          # modeline._args = [
          #   1543.00
          #   3840
          #   3888
          #   3920
          #   4000
          #   2160
          #   2163
          #   2168
          #   2338
          #   "+hsync"
          #   "-vsync"
          # ];

          position._props = {
            x = 0;
            y = 0;
          };

          # variable-refresh-rate = { };
          # max-bpc = 8;
        };
      }
      # {
      #   output = {
      #     _args = [ "DP-2" ];
      #     mode = "2560x2880@59.982";
      #     position._props = {
      #       x = 3200;
      #       y = 0;
      #     };
      #     scale = 1.50;
      #     transform = "normal";
      #   };
      # }
    ];
  };

  nix.settings = {
    cores = 16; # when building don't use all of the cpu cores
    max-jobs = 16;
  };
}
