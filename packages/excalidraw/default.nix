{
  lib,
  pkgs,
  ...
}: {
  packages.excalidraw = with pkgs;
    mkYarnPackage rec {
      pname = "excalidraw-app";
      version = "0.17.6";
      src = fetchFromGitHub {
        owner = "excalidraw";
        repo = "excalidraw-app";
        rev = "v${version}";
        hash = lib.fakeHash;
      };

      offlineCache = fetchYarnDeps {
        yarnLock = "${src}/yarn.lock";
        hash = lib.fakeHash;
      };

      packageJSON = ./package.json;

      configurePhase = ''
        runHook preConfigure
        ln -s $node_modules node_modules
        runHook postConfigure
      '';

      buildPhase = ''
        runHook preBuild

        export HOME=$(mktemp -d)
        yarn --offline run build

        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p $out/dist
        cp -r dist/** $out/dist

        runHook postInstall
      '';

      doDist = false;
    };
}
