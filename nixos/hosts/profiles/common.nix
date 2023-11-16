{
  inputs,
  # homeConfigurations,
  pkgs,
  ...
}: let
in {
  imports = [
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    ../../system/nix.nix
    ../../system/home-manager.nix
    ../../users
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];
}
