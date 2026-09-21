{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
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
    networking
    user

    ./hardware.nix
    ../../profiles/pc.nix

    ./sandboxing.nix

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
