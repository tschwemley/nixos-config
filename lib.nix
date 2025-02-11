lib:
lib
// {
  flattenAttrs = attrset: builtins.concatLists (builtins.attrValues attrset);

  mkStrOption = attrs: lib.mkOption ({type = lib.types.str;} // attrs);

  nixpkgsPatch = system: nixpkgs:
    (import nixpkgs {
      inherit system;
      # config.allowUnfree = true;
    })
    .applyPatches {
      name = "nixpkgs-patched";
      src = nixpkgs;
      patches = import ./patches.nix;
    };

  # define secret paths as constants for convenience
  secrets = {
    home = ./secrets/home;
    nixos = ./secrets/nixos;
    server = ./secrets/server;
  };

  stringList = lib.types.listOf lib.types.str;
}
