{
  inputs,
  config,
  pkgs,
  ...
}: let
  rootUser = (import ../system/users.nix {inherit config pkgs;}).root;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.disko
    rootUser

    ../development
    ../network
    ../virtualisation

    ../programs/home-manager.nix
    ../programs/zsh.nix

    ../services/rclone

    ../system/nix.nix
  ];

  # basic tools I want available on every host and managed by the system
  environment = {
    sessionVariables.TERM = "kitty";
    systemPackages = with pkgs; [
      age
      curl
      git
      gnupg
      ogen
      jq
      lsof
      pinentry
      pwgen
      ripgrep
      rsync
      sops
      tree
      unzip
      wget
      zip
    ];
  };

  hardware.enableRedistributableFirmware = true;
}
