{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  disk = import ../../hardware/disks/btrfs-encrypted.nix "nvme1n1" "crypted";
  networking = {
    imports = [
      ../../network/containers.nix
      ../../network/tailscale.nix
    ];
  };
  user = (import ../../system/users.nix { inherit self config pkgs; }).schwem;
in
{
  imports = [
    disk
    networking
    user

    ./hardware.nix
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
      kernelModules = [ "kvm-intel" ];
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

  services.tailscale.extraUpFlags = [
    "--exit-node=us-chi-wg-303.mullvad.ts.net"
    "--exit-node-allow-lan-access=true"
    "--operator=schwem"
  ];

  # TODO: move below here elsewhere
  systemd.services.tailscaled-autoconnect =
    let
      after = lib.mkDefault [
        "NetworkManager-wait-online"
        "tailscaled.service"
      ];
      wants = after;
    in
    {
      inherit after wants;
    };
}
