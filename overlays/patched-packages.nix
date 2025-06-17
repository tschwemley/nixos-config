_: prev: {
  # BUG: Remove when upstream merged: https://nixpkgs-tracker.ocfox.me/?pr=413721
  # bruno = prev.bruno.overrideAttrs {
  #   patches = [
  #     (prev.fetchpatch {
  #       url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/413721.patch";
  #       hash = "sha256-wy6rjVrflSkGKDXzus8U7Xp0y2pNmXRdWnsBSwRvSl4=";
  #       # sha256 = "67b668c77677bfcaff42031e2656ce9cf173275e1dfd6f72587e8e8726298f09";
  #     })
  #   ];
  # };

  flaresolverr = prev.flaresolverr.overrideAttrs {
    patches = [
      ./patches/flaresolverr.patch
    ];
  };
}
