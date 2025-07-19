_: prev: {
  redlib = prev.redlib.overrideAttrs (oldAttrs: rec {
    pname = "redlib";
    version = "2025-04-21";

    src = prev.fetchFromGitHub {
      owner = "redlib-org";
      repo = "redlib";
      rev = "f1e5aa5e1790c4d7f0d4c5f222771cb3bbbc4b77";
      hash = "sha256-ga+y8iVt+GjqgtLrS/jOC0rMDOhpyGbmYWUfwZDdoaM=";
    };

    # Re-create cargoDeps from scratch using the new src.
    # This is the correct way to update vendored dependencies.
    cargoDeps = prev.rustPlatform.fetchCargoVendor {
      inherit src;

      # set to empty string when needing to update the src.{rev,hash} manually
      hash = "sha256-FDeENHY6bwwCq6leSoIuCqPI6PCHpEod7KN2grS2gFw=";
    };

    passthru.updateScript = prev.nix-update-script {};
  });
}
