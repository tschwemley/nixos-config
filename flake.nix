{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs = inputs @ {
    self,
    home-manager,
    nix-on-droid,
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
      ];
    }));
    eachSystem = fn: lib.genAttrs (import systems) (system: fn pkgsFor.${system});
    hosts = lib.attrNames (builtins.readDir ./nixos/hosts);
  in {
    inherit lib;

    devShells = eachSystem (pkgs: import ./devshell pkgs);
    nixosModules = import ./modules;
    overlays = import ./overlays.nix {inherit self;};
    packages = eachSystem (pkgs: import ./packages pkgs);
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

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
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
      # FIXME: remove the ref after the hash is fixed in next github action
      url = "github:youwen5/zen-browser-flake?ref=ceb2e7122307700e9c310973c793c2c241dc0901";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # imports below here are server-specific imports for schwem.io
    #   TODO: make them into a single repo
    #   TODO: uncomment these after removing flake-parts deps
    # dashboard = {
    #   url = "git+https://git.schwem.io/schwem/dashboard";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    oidcproxy = {
      url = "git+https://git.schwem.io/schwem/oidcproxy";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stash = {
      url = "git+https://git.schwem.io/schwem/stash-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
