{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = {
    self,
    nixpkgs,
    systems,
    ...
  }: let
    inherit (nixpkgs) lib;

    pkgsForSystem = lib.genAttrs (import systems) (system: import nixpkgs {inherit system;});
    eachSystem = fn: lib.genAttrs (import systems) (system: fn pkgsForSystem.${system});
  in {
    inherit lib;

    devShells = eachSystem (pkgs: {
      default = pkgs.mkShell {
        buildInputs = [
          self.packages.${builtins.currentSystem}.default
          # (pkgs.python313.withPackages (pythonPkgs:
          #   with pythonPkgs; [
          #     daphne
          #     django_5
          #     playwright
          #     wand
          #     python-dotenv
          #   ]))
          # script to generate gemset.nix
          # (pkgs.writeShellScriptBin "gem-to-nix" ''
          # ${pkgs.bundix}/bin/bundix --gemfile ${gemDir}/Gemfile --lockfile ${gemDir}/Gemfile.lock
          # '')
        ];
      };
    });

    packages = eachSystem (pkgs: {
      default = pkgs.python313.withPackages (pythonPkgs: with pythonPkgs; []);
    });
  };
}
