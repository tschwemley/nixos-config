# BUG: this can be removed after the short-sighted change that fucked 20+ packages is resolved
# UPSTREAM: https://github.com/NixOS/nixpkgs/issues/425335
self: (_: prev: {
  python3Packages =
    prev.python3Packages
    // {inherit (self.inputs.pinnedTextual.legacyPackages.${prev.system}.python3Packages) textual;};
})
