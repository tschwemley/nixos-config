{
  description = "Basic Python Application";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
      ];

      perSystem = {
        self',
        config,
        lib,
        pkgs,
        system,
        ...
      }: {
        # makes pkgs available to all perSystem functions
        _module.args.pkgs = import nixpkgs {inherit system;};
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          buildInputs = [
            self'.packages.pythonApp
          ];
        };

        packages = {
          pythonApp = let
            depPkgs = ps:
              with ps; [
                # python app required packages go here
              ];
          in
            pkgs.python3.withPackages depPkgs;
        };
      };
    };
}
