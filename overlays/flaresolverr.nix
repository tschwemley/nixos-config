_: prev: {
  flaresolverr = prev.flaresolverr.overrideAttrs {
    patches = [
      ./patches/flaresolverr.patch
    ];
  };
}
