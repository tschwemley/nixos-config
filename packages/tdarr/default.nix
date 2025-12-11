pkgs: {
  node = pkgs.callPackage ./node.nix { };
  server = pkgs.callPackage ./server.nix { };
}
