{
  inputs,
  # homeConfigurations,
  pkgs,
  ...
}: let
in {
  imports = [
    inputs.home-manager.nixosModule
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
	../../users	
	../../system/nix.nix
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];
}
