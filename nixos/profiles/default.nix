{
  inputs,
  config,
  pkgs,
  ...
}:
let
  rootUser = (import ../system/users.nix { inherit config pkgs; }).root;
in
{
  imports = [
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    rootUser
    ../network
    ../programs/home-manager.nix
    ../programs/zsh.nix
    ../system/nix.nix
    ../virtualisation
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    age
    curl
    git
    gnupg
    go
    ogen
    jq
    lsof
    pinentry
    pwgen
    ripgrep
    rsync
    sops
    unzip
    wget
    zip
  ];

  hardware.enableRedistributableFirmware = true;
}
