{
  description = "Basic Node Application Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem =
        {
          config,
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

          devShells.default =
            let
              python = pkgs.python3.withPackages (
                ps: with ps; [
                  distutils
                  gyp
                ]
              );
            in
            pkgs.mkShell {
              buildInputs = with pkgs; [
                python
                nodejs
                prefetch-npm-deps
                prefetch-yarn-deps
                yarn
              ];
            };

          packages = { };
        };
    };
}
