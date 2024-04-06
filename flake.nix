{
  description = "Schwem's NixOS configuration and dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-staging.url = "github:nixos/nixpkgs/staging-next";
    # nixpkgs-master.url = "github:nixos/nixpkgs/master";

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

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-private = {
      # url = "git+ssh://git@github.com/tschwemley/nix-private.git?ref=extra-container";
      url = "git+ssh://git@github.com/tschwemley/nix-private.git";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # neovim = {
    #   url = "~/projects/nix/neovim-config";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: evaluate these later
    # impermanence.url = "github:nix-community/impermanence/master";
    # split-monitor-workspaces = {
    #   url = "github:Duckonaut/split-monitor-workspaces";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  outputs = inputs @ {
    self,
    disko,
    flake-parts,
    home-manager,
    nixos-hardware,
    nixpkgs,
    sops,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
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

          # TODO: move this to overlays/ ?
          overlays = [
            inputs.neovim-nightly-overlay.overlay
            (final: prev: {
              # ollama = inputs'.nixpkgs-stable.legacyPackages.ollama;
              # xz = inputs'.nixpkgs-master.legacyPackages.xz;
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
