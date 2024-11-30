{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem = {
        self',
        config,
        system,
        ...
      }: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = import ./overlays self';
        };
      in {
        # makes pkgs available to all perSystem functions
        _module.args = {inherit pkgs;};
      };

      imports = [
        ./droid
        ./home
        ./nixos
        ./packages
        ./shells
        ./templates
      ];
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
      # TODO: remove the comment and bug designation if this works after updating
      # BUG:
      # url = "github:Mic92/sops-nix/e9b5eef";
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systemd2nix = {
      url = "github:DavHau/systemd2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen-browser = {
    #   url = "github:tschwemley/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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

    webhooks = {
      url = "git+https://git.schwem.io/schwem/webhooks";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };
}
