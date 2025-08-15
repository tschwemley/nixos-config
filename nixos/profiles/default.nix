{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  rootUser = (import ../system/users.nix { inherit self config pkgs; }).root;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko
    rootUser
    self.nixosModules.variables

    ../development
    ../network
    ../virtualisation

    ../programs
    ../programs/home-manager.nix
    ../programs/less.nix
    ../programs/systemutils.nix
    ../programs/zsh.nix

    ../services/fwupd.nix
    ../services/rclone

    ../system
  ];

  hardware.enableRedistributableFirmware = true;

  # TODO: set this in each host file explicitly. Once in all host files remove from here
  # set here by default since at any given time most/all my configs are x86_64-linux
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  sops = {
    age = {
      keyFile = "/etc/sops/age-keys.txt";
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
    defaultSopsFile = ../hosts/${config.networking.hostName}/secrets.yaml;
  };
}
