{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
	nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

	nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = inputs @ {
    self,
    home-manager,
    flake-parts,
	nixos-generators,
	nixos-hardware,
    ...
  }:
    flake-parts.lib.mkFlake { inherit inputs; } {
		imports = [
			./home
			./hosts
			./modules
		];	
			
		systems = [ "x86_64-linux" ];

		perSystem = {
			pkgs,
			inputs',
			...
		}: {
			# ensure packages available to perSystem/withSystem calls
			_module.args.pkgs = inputs'.nixpkgs.legacyPackages;

			devShells.default = pkgs.mkShell {
			  buildInputs = [
				pkgs.alejandra
			  ];
			};

			formatter = pkgs.alejandra;
		};
	};
}
