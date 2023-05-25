{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	disko.url = "github:nix-community/disko";
	disko.inputs.nixpkgs.follows = "nixpkgs";
	
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
	
	impermanence.url = "github:nix-community/impermanence/master";

    nixos-generators.url = "github:nix-community/nixos-generators";
	nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

	nixos-hardware.url = "github:nixos/nixos-hardware/master";

	sops.url = "github:Mic92/sops-nix";
  };

  outputs = inputs @ {
    self,
	disko,
    flake-parts,
    home-manager,
	nixos-generators,
	nixos-hardware,
	sops,
    ...
  }:
    flake-parts.lib.mkFlake { inherit inputs; } {
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

		imports = [
			./home
			./nixos
		];
	};
}
