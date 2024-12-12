{
  inputs,
  config,
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
}
