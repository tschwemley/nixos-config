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

  npmModules = importNpmLock.buildNodeModules {
    inherit nodejs;
    npmRoot = "${repo}/apps/demo";
    packageLock = lib.importJSON ./package-lock.json;
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
      npmModules
    ];

    buildPhase = ''
      runHook preBuild

      mkdir $out
      cp -r $src/* ${npmModules}/node_modules $out/

      cd $out
      npm run build

      runHook postBuild
    '';
  }
