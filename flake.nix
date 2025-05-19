{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs = inputs @ {
    self,
    home-manager,
    nix-on-droid,
    nix-topology,
    nixpkgs,
    systems,
    ...
  }: let
    lib = import ./lib (nixpkgs.lib // home-manager.lib);

    pkgsFor = lib.genAttrs (import systems) (system: (import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        self.overlays.default
        self.inputs.neovim-overlay.overlays.default
        self.inputs.nix-topology.overlays.default
      ];
    }));
    eachSystem = fn: lib.genAttrs (import systems) (system: fn pkgsFor.${system});
    hosts = lib.attrNames (builtins.readDir ./nixos/hosts);
  in {
    inherit lib;

    devShells = eachSystem (pkgs: import ./devshell pkgs);
    nixosModules = import ./modules;
    overlays = import ./overlays.nix {inherit self;};
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

    nixosConfigurations = lib.genAttrs hosts (host:
      lib.nixosSystem {
        specialArgs = {inherit inputs self;};
        modules = [./nixos/hosts/${host}];
      });

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs {system = "aarch64-linux";};
      specialArgs = {inherit inputs self;};
      modules = [./droid];
    };

    # TODO: this needs to be continued to filled out at the individual system level
    topology = import nix-topology {
      pkgs = pkgsFor.x86_64-linux;
      modules = [
        ({config, ...}: let
          inherit (config.lib.topology) mkInternet mkRouter mkConnection;
        in {
          inherit (self) nixosConfigurations;

          networks.home = {
            name = "home";
            cidrv4 = "192.168.1.1/24";
          };
        })
      ];
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # NOTE: uncomment these as required/when necessary for overlays
    # nixpkgs-master.url = "github:nixos/nixpkgs/master";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    nil.url = "github:oxalica/nil";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    systems.url = "github:nix-systems/default";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gbar = {
      url = "github:scorpion-26/gBar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: fix up private appimage import(s)
    hueforge = {
      url = "file:/home/schwem/appimages/HueForge_v0.9.0-beta-1.AppImage";
      flake = false;
    };

    # hyprland-input-capture = {
    #   url = "github:3l0w/Hyprland/feat/input-capture-impl";
    #   # inputs.nixpkgs.follows = "nixpkgs"; # comment this out if trouble building
    # };

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

    # scribe = {
    #   url = "sourcehut:~edwardloveall/scribe/main";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    sops-nix = {
      url = "github:Mic92/sops-nix";
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
      url = "git+https://git.schwem.io/schwem/nix-private";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oidcproxy = {
      url = "git+https://git.schwem.io/schwem/oidcproxy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
