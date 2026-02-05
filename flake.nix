{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs =
    inputs@{
      self,
      home-manager,
      nixpkgs,
      systems,
      # nix-on-droid,  TODO: re-add nix-on-droid when circling back to mobile config
      ...
    }:
    let
      lib = import ./lib (nixpkgs.lib // home-manager.lib);

      pkgsFor = lib.genAttrs (import systems) (
        system:
        (import nixpkgs {
          inherit lib system;

          # Inherit from system nixpkgs option module for consistency between package sets
          inherit ((import ./nixos/system/nixpkgs.nix { inherit self; }).nixpkgs) config overlays;
        })
      );

      eachSystem = fn: lib.genAttrs (import systems) (system: fn pkgsFor.${system});
      hosts = lib.attrNames (builtins.readDir ./nixos/hosts);
    in
    {
      inherit lib;

      devShells = eachSystem (pkgs: import ./devshell pkgs);
      nixosModules = import ./modules;
      overlays = import ./overlays self;
      packages = eachSystem (pkgs: import ./packages self pkgs);
      templates = import ./templates;

      homeConfigurations = {
        #   default = lib.homeManagerConfiguration {
        #     pkgs = pkgsFor."x86_64-linux";
        #     extraSpecialArgs = { inherit inputs self; };
        #     modules = [ ./home/profiles/default.nix ];
        #   };
        #
        #   pc = lib.homeManagerConfiguration {
        #     pkgs = pkgsFor."x86_64-linux";
        #     extraSpecialArgs = { inherit inputs self; };
        #     modules = [ ./home/profiles/pc.nix ];
        #   };
        #
        #   # TODO: For possible solution for building and then deploying remotely to work server
        #   #       see: https://gist.github.com/fricklerhandwerk/fbf0b212bbbf51b79a08fdac8659481d
        #   "work@linux" = lib.homeManagerConfiguration {
        #     pkgs = pkgsFor."x86_64-linux";
        #     extraSpecialArgs = { inherit inputs self; };
        #     modules = [ ./home/profiles/work.nix ];
        #   };

        "work@mac" = lib.homeManagerConfiguration {
          pkgs = pkgsFor."aarch64-darwin";
          extraSpecialArgs = { inherit inputs self; };
          modules = [ ./home/profiles/work.nix ];
        };
      };

      nixosConfigurations = lib.genAttrs hosts (
        host:
        lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            ./nixos/hosts/${host}
          ];
        }
      );

      # nixOnDroidConfigurations = import ./android/nix-on-droid self;
    };

  inputs = {
    #---
    # Nix Related Inputs
    #---
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    systems.url = "github:nix-systems/default";

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli = {
      url = "github:nix-community/nixos-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #---
    # Non-Nix Inputs
    #---

    asus-numberpad-driver = {
      url = "github:asus-linux-drivers/asus-numberpad-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    charm = {
      url = "github:charmbracelet/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lan-mouse = {
      url = "github:feschber/lan-mouse";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-on-droid = {
    #   url = "github:nix-community/nix-on-droid/release-24.05";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };

    # TODO: low prio - add/remove when readressing in future
    # nix-topology = {
    #   url = "github:oddlama/nix-topology";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # imports below here are server-specific imports for schwem.io
    #   TODO: make them into a single repo

    # try removal if upstream fixes BUG: https://github.com/httpjamesm/AnonymousOverflow/issues/175
    anonymous-overflow = {
      url = "git+https://git.schwem.io/schwem/anonymous-overflow";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-private = {
      url = "git+https://git.schwem.io/schwem/nix-private?ref=refactor";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        sops-nix.follows = "sops-nix";
      };
    };

    oidcproxy = {
      url = "git+https://git.schwem.io/schwem/oidcproxy";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    redlib = {
      url = "git+https://git.schwem.io/schwem/redlib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
