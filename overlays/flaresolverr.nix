_: prev: {
  flaresolverr = prev.flaresolverr.overrideAttrs rec {
    version = "3.3.25";
    src = prev.fetchFromGitHub {
      owner = "FlareSolverr";
      repo = "FlareSolverr";
      rev = "v${version}";
      hash = "sha256-AGRqJOIIePaJH0j0eyMFJ6Kddul3yXF6uw6dPMnskmY=";
    };
  };
}
