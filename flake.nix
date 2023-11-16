{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:t184256/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    impermanence.url = "github:nix-community/impermanence/master";
    kubenix.url = "github:hall/kubenix";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    sops.url = "github:Mic92/sops-nix";
  };

  outputs = inputs @ {
    self,
    disko,
    flake-parts,
    home-manager,
    kubenix,
    nixos-hardware,
    nixos-generators,
    nixpkgs,
    sops,
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
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            age
            manix
            nixos-generators.packages.${system}.nixos-generate
            pkgs.sops
            ssh-to-age
            wireguard-tools
          ];
        };

        packages.installer = nixos-generators.nixosGenerate {
          inherit system;
          modules = [
            # ./nixos/modules/system/nix.nix
            # ./nixos/profiles/default.nix
          ];
          format = "install-iso";
        };

        formatter = pkgs.alejandra;
      };

      # # TODO: move this somewhere
      #  packages.x86_64-linux = {
      #  nixnixnix = nixos-generators.nixosGenerate {
      # system = "x86_64-linux";
      # modules = [
      #    # inputs.disko.nixosModules.disko
      #   # ./nixos/modules/system/nix.nix
      # ];
      # format = "install-iso";
      #
      # # optional arguments:
      # # explicit nixpkgs and lib:
      # # pkgs = nixpkgs.legacyPackages.x86_64-linux;
      # # lib = nixpkgs.legacyPackages.x86_64-linux.lib;
      # # additional arguments to pass to modules:
      # # specialArgs = { myExtraArg = "foobar"; };
      #
      # # you can also define your own custom formats
      # # customFormats = { "myFormat" = <myFormatModule>; ... };
      # # format = "myFormat";
      #  };
      #  };
      #
      # Import flake attrs
      imports = [
        ./home
        ./nixos
      ];
    };
}
