{
  inputs,
  pkgs,
  ...
}: let
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    ../modules/programs/zsh.nix
    ../modules/services/openssh.nix
    ../modules/system/nix.nix
    ../modules/users
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    curl
    git
    ripgrep
    rustc
    rustfmt
    wget
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # enable at system level even though managed via home-manager so proper files are sourced
  # home-manager.sharedModules = [
  #
  # ];
}
