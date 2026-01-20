(_: prev: {
  formats = prev.formats // {
    kdl =
      (import ./kdl.nix {
        inherit (prev) lib;
        pkgs = prev;
      }).format;
  };
})
