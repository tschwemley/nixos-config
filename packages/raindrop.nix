{
  fetchFromGitHub,
  buildNpmPackage,
}:
buildNpmPackage {
  name = "raindrop";

  src = fetchFromGitHub {
    owner = "raindropio";
    repo = "app";
    rev = "master";
    hash = "sha256-ZQq0WK/wPQCP0V4rtOBd8T0mPy8lVoBz6E+u3WxDPy8=";
  };

  npmDepsHash = "sha256-/dTNln8NPW5Z973HrFkxUudR3yINM+UTkWszueZxw2U=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];
}
