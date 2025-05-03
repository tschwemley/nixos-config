{
  fetchFromGitHub,
  importNpmLock,
  lib,
  nodejs,
  stdenv,
  typescript
}: let
  pname = "dgmjs";
  version = "0.38.4";

  repo = fetchFromGitHub {
    owner = "dgmjs";
    repo = "dgmjs";
    tag = "v${version}";
    hash = "sha256-46Cac1XVFo9+F1/JFhkq6zkqoUmqYqyYbYZS4P8c2F8=";
  };

  # Import dependencies from package-lock.json, including devDependencies
  nodeDependencies = importNpmLock {
    packageLock = ./package-lock.json;
  };
in
  stdenv.mkDerivation {
    inherit pname version;

    src = "${repo}/apps/demo";

    nativeBuildInputs = [
      nodejs
      typescript
    ];

    buildInputs = [
      # Use the generated node_modules which includes devDependencies
      nodeDependencies.nodeModules
    ];

    buildPhase = ''
      runHook preBuild

      mkdir $out
      # Copy source files and the generated node_modules into the build directory
      cp -r $src/* ${nodeDependencies.nodeModules}/node_modules $out/

      cd $out
      npm run build

      runHook postBuild
    '';
  }
