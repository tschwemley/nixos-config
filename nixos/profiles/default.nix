{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  rootUser = (import ../system/users.nix {inherit config pkgs;}).root;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko
    rootUser

    ../development
    ../network
    ../virtualisation

    ../programs
    ../programs/home-manager.nix
    ../programs/less.nix
    ../programs/zsh.nix

    ../services/rclone

    ../system/nix.nix
    ../system/nixpkgs.nix
  ];

  environment.sessionVariables.TERM = "kitty";
  hardware.enableRedistributableFirmware = true;

  # NOTE: for now I only have x86_64-linux systems. If/when that changes this should be overwritten
  # for other archs, set at the host level, or new profile(s) created.
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
