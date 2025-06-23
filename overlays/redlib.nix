_: prev: {
  redlib = prev.redlib.overrideAttrs (oldAttrs: rec {
    pname = "redlib";
    version = "2025-04-21";

    src = prev.fetchFromGitHub {
      owner = "redlib-org";
      repo = "redlib";
      rev = "dcb507d56710a047c743fe79a5326e4f1ca930a6";
      hash = "sha256-ANNZEDLbiZr3i2FmeyAft8bkKh2xz12dYD8dXEbWe48=";
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
