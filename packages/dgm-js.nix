{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
  nodejs, # Keep nodejs for potential overrides if needed, buildNpmPackage usually provides it
  typescript # Keep typescript in case it's needed globally
}: let
  pname = "dgmjs";
  version = "0.38.4";

  repo = fetchFromGitHub {
    owner = "dgmjs";
    repo = "dgmjs";
    tag = "v${version}";
    hash = "sha256-46Cac1XVFo9+F1/JFhkq6zkqoUmqYqyYbYZS4P8c2F8=";
  };
in
  buildNpmPackage {
    inherit pname version;

    src = "${repo}/apps/demo";

    # Provide the package-lock.json file
    packageLock = ./package-lock.json;

    # Placeholder hash - Nix will tell us the correct one on build failure
    npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

    # buildNpmPackage provides nodejs, but keep typescript if needed globally
    nativeBuildInputs = [
      typescript
    ];

    # buildNpmPackage runs 'npm run build' by default.
    # If a different script is needed, use:
    # npmBuildScript = "your-build-script";

    # If environment variables are needed during build:
    # NIX_NODE_LINK_WORKSPACE = true; # Example

    meta = with lib; {
      description = "dgmjs demo application";
      homepage = "https://github.com/dgmjs/dgmjs";
      license = licenses.mit; # Adjust if needed
      # maintainers = with maintainers; [ yourHandle ]; # Optional
      platforms = platforms.all; # Adjust if needed
    };
  }
