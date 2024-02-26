# See how this flake is used in ./usage.sh
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    extra-container = {
      url = "github:erikarvstedt/extra-container";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    extra-container,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {
        self',
        inputs',
        config,
        lib,
        pkgs,
        system,
        ...
      }: {
        # imports = [./packages];
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        devShells.default = with pkgs;
          mkShell {
            buildInputs = [
              # self'.packages.nxc
              pkgs.extra-container
              sops
            ];
          };

        packages = let
          mkContainer = name: addressPrefix:
            extra-container.lib.buildContainers {
              inherit system;
              config = {
                containers.${name} = {
                  autoStart = true;
                  bindMounts."/root/keys.txt" = {
                    hostPath = "/root/.config/sops/age/keys.txt";
                    isReadOnly = true;
                  };
                  extra = {
                    inherit addressPrefix;
                    enableWAN = true;
                    firewallAllowHost = true;
                    exposeLocalhost = true;
                  };
                  specialArgs = {inherit inputs;};
                  config = {...}: {
                    nixpkgs.config.allowUnfree = true;
                    imports = [
                      inputs.sops.nixosModules.sops
                      ./nixos/${name}
                    ];
                    # This resolves a bug where networking.nameservers were ignored
                    # see: https://github.com/NixOS/nixpkgs/issues/162686
                    networking.useHostResolvConf = lib.mkForce false;
                    networking.nameservers = ["1.1.1.1" "1.0.0.1"];
                    sops.age.keyFile = "/root/keys.txt";
                  };
                };
              };
            };
        in {
          invidious = mkContainer "invidious" "10.10.3";
          keycloak = mkContainer "keycloak" "10.10.1";
          libreddit = mkContainer "libreddit" "10.10.5";
          mysql = mkContainer "mysql" "10.90.1";
          searxng = mkContainer "searxng" "10.10.2";
        };
      };
    };
}
