{
  inputs,
  config,
  pkgs,
  lib,
  utils,
  ...
}: let
  homeManager = inputs.home-manager.nixosModule {
    inherit config lib pkgs utils;
    home-manager.useGlobalPkgs = true;
    home.stateVersion = 23.05;
  };
in {
  imports = [
    homeManager
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    # ./system/nix.nix
  ];

  # basic tools
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];

  services.openssh.enable = true;
}
