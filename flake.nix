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

    flake-parts.url = "github:hercules-ci/flake-parts";
    impermanence.url = "github:nix-community/impermanence/master";
    kubenix.url = "github:hall/kubenix";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    sops.url = "github:Mic92/sops-nix";
  };

  outputs = inputs @ {
    self,
    disko,
    flake-parts,
    home-manager,
    kubenix,
    nixos-hardware,
    nixpkgs,
    sops,
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
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixos-generators
            pkgs.sops
            ssh-to-age
            wireguard-tools
          ];
        };

        formatter = pkgs.alejandra;
      };

      # Import flake attrs
      imports = [
        ./home
        ./nixos
      ];
    };
}
