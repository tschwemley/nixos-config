{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
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

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            air
            go
          ];
        };

        packages.default = pkgs.buildGoModule {
          name = "file-utils";
          src = ./.;
          vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
      };
    };
}
