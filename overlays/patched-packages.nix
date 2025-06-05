_: prev: {
  # BUG: Remove when upstream merged: https://nixpkgs-tracker.ocfox.me/?pr=413721
  bruno = prev.bruno.overrideAttrs (old: {
    patches = (old.patches or []) ++ [./patches/bruno-nixpkgs-413721.patch];
  });
}
