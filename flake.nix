{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    nix-private = {
      url = "git+ssh://git@github.com/tschwemley/nix-private.git";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    disko,
    flake-parts,
    home-manager,
    nixpkgs,
    sops,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        self',
        inputs',
        config,
        pkgs,
        system,
        ...
      }: {
        # makes pkgs available to all perSystem functions
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;

          # NOTE: there might be a better spot for overlays long-term. I'm okay w/ here for now
          overlays = [
            inputs.neorg-overlay.overlays.default
            (final: prev: {
              # TODO: decide if keeping brave overlay or removing
              # brave =
              #   prev.brave.override {
              #       # commandLineArgs = "--remote-debugging-port=9222";
              #   };
              hypreasymotion = self'.packages.hypreasymotion;
              keycloak = prev.keycloak.overrideAttrs (old: rec {
                version = "24.05";
                src = pkgs.fetchzip {
                  url = "https://github.com/keycloak/keycloak/releases/download/${version}/keycloak-${version}.zip";
                  hash = "sha256-DYuK1W8dXI/UUB+9HzMnjiJdpJulS3QuIpmr3AA4OLo=";
                };
              });
              redlib = self'.packages.redlib;
              vimPlugins =
                prev.vimPlugins
                // {
                  codecompanion = self'.packages.codecompanion;
                  neogit-nightly = self'.packages.neogit-nightly;
                };
              wl-ocr = self'.packages.wl-ocr;
            })
          ];
        };

        formatter = pkgs.alejandra;
      };

      imports = [
        ./home
        ./nixos
        ./packages
        ./shells
        ./templates
      ];
    };
}
