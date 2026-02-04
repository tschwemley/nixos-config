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

    # TODO: make systemd boot import from the nixos/pc profile (unless pika is an exception for some reason)
    ../../system/boot/systemd.nix

    # TODO: move this to a profile
    # ../../services/llama-cpp.nix
  ];

  networking = {
    enableIPv6 = true;
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.05";
}
