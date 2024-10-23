{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
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
      ../../network/tailscale.nix
    ];
  };
  ollama = import ../../../containers/ollama "/home/schwem/.ollama";
  open-webui = import ../../../containers/open-webui "/home/schwem/.open-webui";
  sillytavern = import ../../../containers/sillytavern "/home/schwem/.sillytavern";
  user = (import ../../system/users.nix { inherit config pkgs; }).schwem;
in
{
  imports = [
    disk
    hardware
    networking
    ollama
    open-webui
    sillytavern
    user
    ./secrets.nix
    ../../system/boot/systemd.nix
    # ../../services/samba.nix
    ../../profiles/pc.nix
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
      kernelModules = [
        "amdgpu"
        "kvm-intel"
      ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  home-manager.users.schwem.hyprland = rec {
    monitors = {
      primary = "DP-2";
      config = [
        # "DP-2, 3840x2160@120, 0x0, 1, vrr, 0, bitdepth, 10, transform, 3"
        # "DP-2, 3840x2160@120, 0x0, 1, vrr, 0, transform, 3"
        "DP-2, 3840x2160@120, 0x0, 1, vrr, 0"
      ];
    };
    workspaces = [
      "1, monitor:${monitors.primary}"
      "2, monitor:${monitors.primary}"
      "3, monitor:${monitors.primary}"
      "4, monitor:${monitors.primary}"
    ];
  };

  networking = {
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.resolved.dnsovertls = lib.mkDefault "true";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.05";

  systemd.services."NetworkManager-wait-online.service".enable = lib.mkForce false;

  services.tailscale.extraUpFlags = [
    "--exit-node=us-chi-wg-302.mullvad.ts.net"
    "--exit-node-allow-lan-access=true"
    "--shields-up"
  ];
  time.timeZone = "America/Detroit";

  users.mutableUsers = true; # allow mutable users on non-servers
}
