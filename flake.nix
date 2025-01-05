{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs = {
    self,
    home-manager,
    nixpkgs,
    systems,
    ...
  } @ inputs: let
    lib = nixpkgs.lib // home-manager.lib // (import ./lib.nix);

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

    devShells = eachSystem (pkgs: import ./shells pkgs);
    packages = eachSystem (pkgs: import ./packages pkgs);

    nixosConfigurations = lib.genAttrs hosts (host:
      lib.nixosSystem {
        specialArgs = {inherit inputs self;};
        modules = [./nixos/hosts/${host}];
      });
  };

  # outputs = inputs @ {flake-parts, ...}:
  # flake-parts.lib.mkFlake {inherit inputs;} {
  #   systems = [
  #     "aarch64-darwin"
  #     "aarch64-linux"
  #     "x86_64-linux"
  #   ];
  #
  #   imports = [
  #     ./droid
  #     ./home
  #     ./nixos
  #     ./packages
  #     ./shells
  #     ./templates
  #   ];
  # };

  inputs = {
    # BUG: upstream fucked up another giant dependency yet again
    # TODO: remove after upstream fix.....
    rocmPackages-pin.url = "github:NixOS/nixpkgs/585f76290ed66a3fdc5aae0933b73f9fd3dca7e3";

    # BUG: need to use master atm for several deps to work + webcord. Too lazy to pin.
    nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default-linux";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scribe = {
      url = "sourcehut:~edwardloveall/scribe/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi.url = "github:sxyazi/yazi";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # imports below here are server-specific imports for schwem.io TODO: make this into a single repo
    dashboard = {
      url = "git+https://git.schwem.io/schwem/dashboard";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    oidcproxy = {
      url = "git+https://git.schwem.io/schwem/oidcproxy";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    stash = {
      url = "git+https://git.schwem.io/schwem/stash-flake";
      # url = "/home/schwem/projects/nix/stashapp";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    webhooks = {
      url = "git+https://git.schwem.io/schwem/webhooks";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };
}
