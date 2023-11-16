{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
	disko.url = "github:nix-community/disko";
	disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
	
	impermanence.url = "github:nix-community/impermanence/master";

	flake-parts.url = "github:hercules-ci/flake-parts";

#TODO: determine if still needed
 #    nixos-generators.url = "github:nix-community/nixos-generators";
	# nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
	
	nixos-hardware.url = "github:nixos/nixos-hardware/master";
	
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	sops.url = "github:Mic92/sops-nix";
  };

    outputs = inputs @ { 
		nixpkgs, 
		flake-parts, 
		disko,
		home-manager,
		# nixos-generators,
		nixos-hardware,
		sops,
		...
	}: flake-parts.lib.mkFlake { inherit inputs; } {
		systems = [
			"x86_64-linux"
		];

		perSystem = { pkgs, system }: {
			
		};

		flake = with inputs; {
			imports = [
				./hosts
				./modules
			];
		};
	};
}
