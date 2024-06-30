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

          # NOTE: might be a better spot for overlays long-term. I'm okay w/ here for now
          overlays = [
            # TODO: uncomment in a few days to see if upstream issue sorted (05/22/24)
            # inputs.neovim-nightly-overlay.overlay
            inputs.neorg-overlay.overlays.default
            (final: prev: {
              hypreasymotion = self'.packages.hypreasymotion;
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
