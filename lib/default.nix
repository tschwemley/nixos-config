# Contains the default configuration for home-manager and support functions for
# building systems.
# TODO: consider moving away from lib paradigm
{ self, inputs, config, ... }:
{
  flake = {
    # Linux home-manager module
    nixosModules.home-manager = {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        ({
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            system = "x86_64-linux";
            flake = { inherit config; };
          };
        })
      ];
    };
    # macOS home-manager module
    darwinModules.home-manager = {
      imports = [
        inputs.home-manager.darwinModules.home-manager
        ({
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            system = "aarch64-darwin";
            flake = { inherit config; };
          };
        })
      ];
    };

    lib = {
      mkUser = name: extraModules: {
      	imports = [
		"${self.lib.paths.users}/${name}.nix"
	];
      };

      mkLinuxSystem = mod: inputs.nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        # Arguments to pass to all modules.
        specialArgs = {
          inherit system inputs;
          flake = { inherit config; };
        };
        modules = [ mod ];
      };

      mkMacosSystem = mod: inputs.darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs system;
          flake = { inherit config; };
          rosettaPkgs = import inputs.nixpkgs { system = "x86_64-darwin"; };
        };
        modules = [ mod ];
      };

      paths = {
      	home = builtins.toString ../home;
      	hosts = builtins.toString ../hosts;
      	lib = builtins.toString ../lib;
      	users = builtins.toString ../users;
      };
    };

  };
}

