{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence/master";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    sops.url = "github:Mic92/sops-nix";
  };
  
  outputs = inputs @ {
    self,
    disko,
    flake-parts,
    home-manager,
    nixos-hardware,
    nixpkgs,
    sops,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      # debug = true;
      systems = [
        "x86_64-linux"
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
		_module.args.pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
		
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            alejandra
            nixos-generators
            pkgs.sops
            ssh-to-age
          ];
        };
      };

      # Import flake attrs
      imports = [
        ./home
        ./nixos
      ];
    };
}
