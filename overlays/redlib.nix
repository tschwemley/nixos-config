_: prev: {
  redlib = prev.redlib.overrideAttrs rec {
    version = "2025-04-21";

    src = prev.fetchFromGitHub {
      inherit version;

      owner = "redlib-org";
      repo = "redlib";
      rev = "dcb507d56710a047c743fe79a5326e4f1ca930a6";
      hash = "sha256-ANNZEDLbiZr3i2FmeyAft8bkKh2xz12dYD8dXEbWe48=";
    };

    passthru.updateScript = prev.nix-update-script {};
  };
}
