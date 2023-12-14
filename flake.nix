{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence/master";
    musnix.url = "github:musnix/musnix";

    nix-on-droid = {
      url = "github:t184256/nix-on-droid/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops.url = "github:Mic92/sops-nix";

    # TODO: consider moving this into it's own config w/ other hyprland items in the future
    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs @ {
    self,
    disko,
    flake-parts,
    home-manager,
    nixos-hardware,
    nixpkgs,
    nix-on-droid,
    sops,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        # makes pkgs available to all perSystem functions
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        formatter = pkgs.alejandra;
      };

      imports = [
        ./apps
        ./droid
        ./home
        ./hydra
        ./nixos
        ./packages
        ./shells
        ./templates
      ];
    };
}
