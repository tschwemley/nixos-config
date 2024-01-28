{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    ../network
    ../programs/home-manager.nix
    ../programs/zsh.nix
    ../system/nix.nix
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    age
    curl
    git
    gnupg
    go
    jq
    lsof
    pinentry
    ripgrep
    rsync
    seaweedfs
    sops
    unzip
    wget
    zip
  ];

  # nixpkgs.config.allowUnfree = lib.mkDefault true;
}
