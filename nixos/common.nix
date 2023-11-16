{
  inputs,
  pkgs,
  ...
}: let
  homeManager = inputs.home-manager.nixosModule {
    home-manager.useGlobalPkgs = true;
  };
in {
  imports = [
    homeManager
    inputs.sops.nixosModules.sops
    inputs.disko.nixosModules.disko
    ./system/nix.nix
  ];

  # basic tools
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];

  services.openssh.enable = true;
}
