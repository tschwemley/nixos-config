# TODO: clean this up and standardize
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops.nixosModules.sops
    ../modules/programs/zsh.nix
    ../modules/services/openssh.nix
    ../modules/system/nix.nix
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    curl
    git
    gnupg
    htop
    jq
    lsof
    pinentry
    ripgrep
    rsync
    unzip
    wget
    zip
  ];

  nixpkgs.config.allowUnfree = lib.mkDefault true;
}
