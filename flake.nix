{
  description = "Schwem's NixOS configuration and dotfiles";

  outputs =
    inputs@{
      self,
      home-manager,
      nixpkgs,
      systems,
      # nix-on-droid,  TODO: re-add nix-on-droid when circling back to mobile config
      ...
    }:
    let
      lib = import ./lib (nixpkgs.lib // home-manager.lib);

      pkgsFor = lib.genAttrs (import systems) (
        system:
        (import nixpkgs {
          inherit system;

          # Inherit from system nixpkgs option module for consistency between package sets
          inherit ((import ./nixos/system/nixpkgs.nix { inherit self; }).nixpkgs) config overlays;
        })
        // {
          inherit lib;
        }
      );

      eachSystem = fn: lib.genAttrs (import systems) (system: fn pkgsFor.${system});
      hosts = lib.attrNames (builtins.readDir ./nixos/hosts);

      # nixpkgs-patched = (import nixpkgs { system = "x86_64-linux"; }).applyPatches {
      #   name = "nixpkgs-patched-451188";
      #   src = nixpkgs;
      #   patches = [
      #     (builtins.fetchurl {
      #       url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/451188.diff";
      #       sha256 = "sha256-5OAw+WsHoBbHI1kpvHBZU8W0hFvBgSXbNtyLq2bscGQ=";
      #     })
      #   ];
      # };

      # nixpkgs-test = import nixpkgs-patched {
      #   overlays = builtins.attrValues self.overlays;
      #
      #   config = {
      #     allowUnfree = true;
      #     android_sdk = {
      #       accept_license = true;
      #     };
      #     rocmSupport = true;
      #   };
      #   system = "x86_64-linux";
      # };
    in
    {
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
          extraSpecialArgs = { inherit inputs self; };
          modules = [ ./home/profiles/work.nix ];
        };
        "work@mac" = lib.homeManagerConfiguration {
          pkgs = pkgsFor."aarch64-darwin";
          extraSpecialArgs = { inherit inputs self; };
          modules = [ ./home/profiles/work.nix ];
        };
      };

      nixosConfigurations = lib.genAttrs hosts (
        host:
        lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = [
            # {
            #   nixpkgs.pkgs = nixpkgs-test;
            # }
            ./nixos/hosts/${host}
          ];
        }
      );

      nixOnDroidConfigurations = import ./android/nix-on-droid self;
    };

  inputs = {
    #---
    # Nix Related Inputs
    #---
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-rocm-patch.url = "github:nixos/nixpkgs?rev=d33e926c80e6521a55da380a4c4c44a7462af405";
    # nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    systems.url = "github:nix-systems/default";

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #---
    # Non-Nix Inputs
    #---

    charm = {
      url = "github:charmbracelet/nur";
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

    # hyprland.url = "github:hyprwm/Hyprland";
    #
    hyprland-easymotion = {
      url = "github:zakk4223/hyprland-easymotion";
      inputs = {
        # hyprland.follows = "hyprland";
        # nixpkgs.follows = "hyprland/nixpkgs";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # hypridle = {
    #   url = "github:hyprwm/hypridle";
    #   inputs = {
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };
    #
    # hyprlock = {
    #   url = "github:hyprwm/hyprlock";
    #   inputs = {
    #     hyprgraphics.follows = "hyprland/hyprgraphics";
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

    lan-mouse = {
      url = "github:feschber/lan-mouse";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    librechat = {
      url = "github:tschwemley/librechat-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # TODO: low prio - add/remove when readressing in future
    # nix-topology = {
    #   url = "github:oddlama/nix-topology";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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
        sops-nix.follows = "sops-nix";
      };
    };

    oidcproxy = {
      url = "git+https://git.schwem.io/schwem/oidcproxy";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    redlib = {
      url = "git+https://git.schwem.io/schwem/redlib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
