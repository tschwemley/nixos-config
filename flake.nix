{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    # Principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    home-manager,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {
        pkgs,
        config,
        lib,
        utils,
        inputs',
        ...
      }: {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.alejandra
          ];
        };

        formatter = pkgs.alejandra;

        # config.pkgs = pkgs;
  #       _module.pkgs = inputs.nixpkgs;
		# _module.args = { inherit pkgs config lib utils; };
      };

      # modules = [./modules];

      imports = [
        ./home
        ./nixos
      ];
	};
}
