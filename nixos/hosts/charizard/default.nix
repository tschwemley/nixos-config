{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  disk = import ../../hardware/disks/btrfs-encrypted.nix "nvme1n1" "crypted";
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
      ../../network/tailscale.nix
    ];
  };
  ollama = import ../../../containers/ollama "/home/schwem/.ollama";
  user = (import ../../system/users.nix {inherit config pkgs;}).schwem;
in {
  imports = [
    disk
    hardware
    networking
    ollama
    user
    ../../profiles/pc.nix

    ../../system/boot/systemd.nix
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
      kernelModules = ["kvm-intel"];
    };
  };

  home-manager.users.schwem = {
    hyprland = let
      primary = "DP-2";
      secondary = "HDMI-A-1";
    in {
      monitors = {
        inherit primary;
        config = [
          # name, resolution, position, scale, vrr, vrr_mode
          "${primary}, 3840x2160@120, 0x0, 1, vrr, 0"
          "${secondary}, 1920x1080@60, 0x2160, 1.2"
        ];
      };
      workspaces = [
        "1, monitor:${primary}, default:true"
        "2, monitor:${primary}"
        "3, monitor:${primary}"
        "4, monitor:${primary}"

        # NOTE: disabled while seconary monitor is down
        # "5, monitor:${secondary}, default:true"
        # "6, monitor:${secondary}"
        # "7, monitor:${secondary}"
        # "8, monitor:${secondary}"
      ];
    };
  };

  networking = {
    enableIPv6 = true;
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.05";

  # systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  services.tailscale.extraUpFlags = [
    "--exit-node=us-chi-wg-303.mullvad.ts.net"
    "--exit-node-allow-lan-access=true"
    "--operator=schwem"
  ];

  # TODO: move below here elsewhere

  # ---
  hardware.opentabletdriver.enable = true;

  systemd.services.tailscaled-autoconnect = let
    after = lib.mkDefault [
      "NetworkManager-wait-online"
      "tailscaled.service"
    ];
    wants = after;
  in {
    inherit after wants;
  };
}
