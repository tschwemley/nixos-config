{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    ../modules/programs/thefuck.nix
    ../modules/programs/zsh.nix
    ../modules/services/openssh.nix
    ../modules/system/nix.nix
    ../modules/users
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    jq
    ripgrep
    unzip
    wget
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;
}
