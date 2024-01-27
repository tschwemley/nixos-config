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
    ../services/openssh.nix
    ../system/nix.nix
    ../modules/users
  ];

  # basic tools I want available on every host and managed by the system
  environment.systemPackages = with pkgs; [
    age
    amdgpu_top
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

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;
}
