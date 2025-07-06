{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs = inputs @ {
    self,
    home-manager,
    nix-topology,
    nixpkgs,
    systems,
    # nix-on-droid,  TODO: re-add nix-on-droid when circling back to mobile config
    ...
  }: let
    lib = import ./lib (nixpkgs.lib // home-manager.lib);

    pkgsFor = lib.genAttrs (import systems) (
      system:
        (import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
          overlays = with self.overlays; [
            default
            patchedPackages
            neovim
            # self.inputs.neovim-overlay.overlays.default
            self.inputs.nix-topology.overlays.default
          ];
        })
        // {
          inherit lib;
        }
    );

    eachSystem = fn: lib.genAttrs (import systems) (system: fn pkgsFor.${system});
    hosts = lib.attrNames (builtins.readDir ./nixos/hosts);
  in {
    inherit lib;

    devShells = eachSystem (pkgs: import ./devshell pkgs);
    nixosModules = import ./modules;
    overlays = import ./overlays self;
    packages = eachSystem (pkgs: import ./packages self pkgs);
    templates = import ./templates;

    homeConfigurations = {
      # TODO: For possible solution for building and then deploying remotely to work server
      #       see: https://gist.github.com/fricklerhandwerk/fbf0b212bbbf51b79a08fdac8659481d
      "work@linux" = lib.homeManagerConfiguration {
        pkgs = pkgsFor."x86_64-linux";
        extraSpecialArgs = {inherit inputs self;};
        modules = [./home/profiles/work.nix];
      };
      "work@mac" = lib.homeManagerConfiguration {
        pkgs = pkgsFor."aarch64-darwin";
        extraSpecialArgs = {inherit inputs self;};
        modules = [./home/profiles/work.nix];
      };
    };

    nixosConfigurations = lib.genAttrs hosts (
      host:
        lib.nixosSystem {
          specialArgs = {inherit inputs self;};
          modules = [./nixos/hosts/${host}];
        }
    );

    nixOnDroidConfigurations = import ./android/nix-on-droid self;
    # nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
    #   pkgs = import nixpkgs {system = "aarch64-linux";};
    #   specialArgs = {inherit inputs self;};
    #   modules = [./android];
    # };

    # TODO: this needs to be continued to filled out at the individual system level
    topology = import nix-topology {
      pkgs = pkgsFor.x86_64-linux;
      modules = [
        (
          {config, ...}: let
            inherit (config.lib.topology) mkInternet mkRouter mkConnection;
          in {
            inherit (self) nixosConfigurations;

            networks.home = {
              name = "home";
              cidrv4 = "192.168.1.1/24";
            };
          }
        )
      ];
    };
  };

  inputs = {
    #---
    # Nix Related Inputs
    #---
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    systems.url = "github:nix-systems/default";

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-update = {
      url = "github:Mic92/nix-update";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #---
    # Non-Nix Inputs
    #---

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: trial and replace waybar or remove
    gbar = {
      url = "github:scorpion-26/gBar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: refactor private appimage import(s)
    hueforge = {
      url = "file:/home/schwem/appimages/HueForge_v0.9.0-beta-1.AppImage";
      flake = false;
    };

    librechat = {
      url = "github:tschwemley/librechat-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-topology = {
      url = "github:oddlama/nix-topology";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
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
        nix-update.follows = "nix-update";
        sops-nix.follows = "sops-nix";
      };
    };

    oidcproxy = {
      url = "git+https://git.schwem.io/schwem/oidcproxy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
