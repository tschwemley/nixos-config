{
  inputs,
  pkgs,
  ...
}: let
in {
  imports = [
    inputs.home-manager.nixosModule
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    ../modules/services/openssh.nix
    ../modules/system/nix.nix
    ../modules/users
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    curl
    git
	rustc
	rustfmt
    wget
  ];

  home-manager.useGlobalPkgs = true;
}
