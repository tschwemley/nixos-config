{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:t184256/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    impermanence.url = "github:nix-community/impermanence/master";
    kubenix.url = "github:hall/kubenix";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    sops.url = "github:Mic92/sops-nix";
    terranix.url = "github:terranix/terranix";
  };

  outputs = inputs @ {
    self,
    disko,
    flake-parts,
    home-manager,
    kubenix,
    nixos-hardware,
    nixos-generators,
    nixpkgs,
    sops,
    terranix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
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
        ./home
        ./nixos
#./packages
        ./shells
      ];
    };
}
