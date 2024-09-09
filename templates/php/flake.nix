{
  description = "Basic PHP Application Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops.url = "github:Mic92/sops-nix";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      sops,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem =
        {
          self',
          config,
          lib,
          pkgs,
          system,
          ...
        }:
        {
          # makes pkgs available to all perSystem functions
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              age
              php
              phpunit
              php82Packages.composer
              php82Packages.psysh
              pkgs.sops
            ];
          };
        };
    };
}
