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

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    musnix.url = "github:musnix/musnix";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    sops.url = "github:Mic92/sops-nix";

    llama-cpp.url = "github:ggerganov/llama.cpp";

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
    llama-cpp,
    nixos-hardware,
    nixpkgs,
    sops,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
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

          # TODO: move this to overlays/
          overlays = [
            (final: prev: {
              llama-cpp = inputs'.llama-cpp.packages.rocm;
              ollama = prev.ollama.overrideAttrs {
                postPatch = ''
                  substituteInPlace llm/llama.go \
                    --subst-var-by llamaCppServer "${llama-cpp}/bin/llama-server"
                  substituteInPlace server/routes_test.go --replace "0.0.0" "${final.ollama.version}"
                '';
              };
            })
          ];
        };

        formatter = pkgs.alejandra;
      };

      imports = [
        ./home
        ./nixos
        ./overlays
        ./packages
        ./shells
        ./templates
      ];
    };
}
