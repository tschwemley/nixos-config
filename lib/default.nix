lib:
lib
// {
  hosts = lib.attrNames (builtins.readDir ../nixos/hosts);

  flattenAttrs = attrset: builtins.concatLists (builtins.attrValues attrset);

  # TODO: change isPC and isServer to read from a config (json?) file. Or make it an option def.
  isPC =
    host:
    builtins.elem host [
      "charizard"
      "pikachu"
    ];

  isServer =
    host:
    builtins.elem host [
      "articuno"
      "zapdos"
      "moltres"
      "jolteon"
      "flareon"
    ];

  mkStrOption = attrs: lib.mkOption ({ type = lib.types.str; } // attrs);

  nixpkgsPatch =
    system: nixpkgs:
    (import nixpkgs {
      inherit system;
      # config.allowUnfree = true;
    }).applyPatches
      {
        name = "nixpkgs-patched";
        src = nixpkgs;
        patches = import ./patches.nix;
      };

  secret = type: filename: ../secrets/${type}/${filename};

  # define secret paths as constants for convenience
  secrets = {
    home = ../secrets/home;
    nixos = ../secrets/nixos;
    server = ../secrets/server;
  };

  stringList = lib.types.listOf lib.types.str;

  port-map = with builtins; fromJSON (readFile ./port-map.json);

  # Gets the system defined for the nixpkgs passed
  system = pkgs: pkgs.stdenv.hostPlatform.system;
}
