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
  ];

  networking = {
    hostName = "pikachu";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  system = {
    # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
    stateVersion = "24.05";
  };

  # ---
  # Laptop specific options
  # ---
  environment.systemPackages = with pkgs; [
    asusctl
    supergfxctl
  ];

  services = {
    asusd.enable = true;

    libinput = {
      enable = true;
      touchpad.tapping = false;
    };

    thermald.enable = lib.mkDefault true;
  };
}
