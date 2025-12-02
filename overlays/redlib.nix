self:
(_: prev: {
  # NOTE: this is in case of want/need to revert back to using flake instead of nixpkgs version
  # redlib = self.inputs.redlib.packages.${prev.system}.default;
  redlib = prev.redlib.overrideAttrs {
    patches = [
      (prev.fetchpatch {
        url = "https://patch-diff.githubusercontent.com/raw/redlib-org/redlib/pull/507.diff";
        hash = "sha256-D4/RynxxutHexyepXGs80C9qncQ7/p/s+S+g5BmZx/Y=";
      })
    ]
    ++ prev.redlib.patches;
  };
})
