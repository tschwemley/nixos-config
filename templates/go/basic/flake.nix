{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = {
    nixpkgs,
    systems,
    ...
  }: let
    inherit (nixpkgs) lib;
    eachSystem = lib.genAttrs (import systems);
    systemPkgs = system: nixpkgs.legacyPackages.${system};
  in {
    devShells = eachSystem (system: let
      pkgs = systemPkgs system;
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          go
          (writeShellScriptBin "modupdate" "go get -u -t ./...")
        ];
      };
    });

    packages = eachSystem (system: let
      pkgs = systemPkgs system;
    in {
      default = pkgs.buildGoModule {
        name = "";
        src = ./.;
        vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
    });
  };
}
