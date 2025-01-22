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

    ../services/fwupd.nix
    ../services/rclone

    ../system/nix.nix
    ../system/nixpkgs.nix
  ];

  environment.sessionVariables.TERM = "kitty";
  hardware.enableRedistributableFirmware = true;

  # set here by default since at any given time most/all my configs are x86_64-linux
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
