{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs = {
    self,
    home-manager,
    nix-on-droid,
    nixpkgs,
    systems,
    ...
  } @ inputs: let
    lib = import ./lib.nix (nixpkgs.lib // home-manager.lib);

    systemPackages =
      lib.genAttrs (import systems)
      (
        system: let
          nixpkgs' = (import ./nixos/system/nixpkgs.nix {inherit self inputs;}).nixpkgs;
        in
          import nixpkgs {
            inherit system;
            inherit (nixpkgs') config overlays;
          }
      );

    eachSystem = fn: lib.genAttrs (import systems) (system: fn systemPackages.${system});
    hosts = lib.attrNames (builtins.readDir ./nixos/hosts);
  in {
    inherit lib;

    devShells = eachSystem (pkgs: import ./devshell pkgs);
    packages = eachSystem (pkgs: import ./packages pkgs);

    nixosConfigurations = lib.genAttrs hosts (host:
      lib.nixosSystem {
        specialArgs = {inherit inputs self;};
        modules = [./nixos/hosts/${host}];
      });

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs {system = "aarch64-linux";};
      modules = [./droid];
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/default-linux";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
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
    #   TODO: uncomment these after removing flake-parts deps
    dashboard = {
      url = "git+https://git.schwem.io/schwem/dashboard";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oidcproxy = {
      url = "git+https://git.schwem.io/schwem/oidcproxy";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stash = {
      url = "git+https://git.schwem.io/schwem/stash-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    webhooks = {
      url = "git+https://git.schwem.io/schwem/webhooks";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
