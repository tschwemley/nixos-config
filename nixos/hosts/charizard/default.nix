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
  user = (import ../../system/users.nix { inherit config pkgs; }).schwem;
in
{
  imports = [
    disk
    hardware
    networking
    ollama
    open-webui
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
    wireless.enable = true;
  };

  services.resolved.dnsovertls = lib.mkDefault "true";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.05";

  services.tailscale.extraUpFlags = [
    "--exit-node=100.84.59.97"
    "--exit-node-allow-lan-access=true"
    "--shields-up"
  ];
  time.timeZone = "America/Detroit";

  users.mutableUsers = true; # allow mutable users on non-servers

  # hardware.display = {
  #   edid = {
  #     enable = true;
  #     packages = [
  #       (pkgs.runCommand "edid-g9" { } ''
  #         mkdir -p "$out/lib/firmware/edid"
  #         base64 -d > "$out/lib/firmware/edid/g9.bin" <<'EOF'
  #         AP///////wBMLVNwUzhYQykeAQS1dyJ4OsclsUtGqCYOUFS/74BxT4EAgcCBgKnAswCVANHAGmgAoPA4H0AwIDoAqVBBAAAaAAAA/Qgy8B5mwgAKICAgICAgAAAA/ABMQzQ5Rzk1VAogICAgAAAA/wBINFpOQTAxNDY5CiAgAroCAyLwRBBaP1wjCQcHgwEAAOMFwADmBgUBi3MS5QGLhJABVl4AoKCgKVAwIDUAqVBBAAAaWE0AuKE4FED4LEUAqVBBAAAedNYAoPA4QEAwIDoAqVBBAAAab8IAoKCgVVAwIDUAqVBBAAAaAAAAAAAAAAAAAAAAAAAAAAAAAAAAgnASeQAAAwFkB/UCiP8TPwF/gB8AnwUuACAABwAveQEI/xOfAC+AHwCfBVMAAgAJADO3AAj/E58AL4AfAJ8FKAACAAkA424BCP8JTwAHgB8AnwUqACAABwCQxwEI/w6fAC+AHwA3BIYAAgAJAAAAAAAAAAAAAAAAAAAAAAAAALKQ
  #         EOF
  #       '')
  #     ];
  #   };
  #
  #   outputs."DP-1".edid = "g9.bin";
  # };
  environment.pathsToLink = [ "/share/zsh" ];
}
