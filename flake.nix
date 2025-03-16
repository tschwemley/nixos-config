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

    pkgsFor = lib.genAttrs (import systems) (system: (import ./nixpkgs.nix {inherit self system;}));
    eachSystem = fn: lib.genAttrs (import systems) (system: fn pkgsFor.${system});
    hosts = lib.attrNames (builtins.readDir ./nixos/hosts);
  in {
    inherit lib;

    devShells = eachSystem (pkgs: import ./devshell inputs pkgs);
    nixosModules = import ./modules;
    overlays = import ./overlays.nix {inherit self;};
    packages = eachSystem (pkgs: import ./packages pkgs);
    templates = import ./templates;

    homeConfigurations = {
      # TODO: For possible solution for building and then deploying remotely to work server
      #       see: https://gist.github.com/fricklerhandwerk/fbf0b212bbbf51b79a08fdac8659481d
      "work@linux" = let
        pkgs = pkgsFor."x86_64-linux";
      in
        lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {inherit inputs self;};
          modules = [./home/profiles/work.nix];
        };
    };

    nixosConfigurations = lib.genAttrs hosts (host: let
      # atm all nixos hosts are x86_64-linux
      pkgs = pkgsFor."x86_64-linux";
    in
      lib.nixosSystem {
        specialArgs = {inherit inputs pkgs self;};
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
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";

    nil.url = "github:oxalica/nil";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-input-capture = {
      url = "github:3l0w/Hyprland/feat/input-capture-impl";
      # inputs.nixpkgs.follows = "nixpkgs"; # comment this out if trouble building
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

    noogle = {
      url = "github:nix-community/noogle";
      inputs = {
        nixpkgs-master.follows = "nixpkgs-master";
        nixpkgs.follows = "nixpkgs";
      };
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
  };
}
