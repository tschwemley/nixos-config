{
  stdenv,
  lib,
  makeWrapper,
  fetchzip,
  ffmpeg,
  mkvtoolnix-cli,
  handbrake,
  ccextractor,
  apprise,
}:

let
  binName = "Tdarr_Server";
  # Not used at the moment
  #trayBinName = "Tdarr_Server_Tray";
in
stdenv.mkDerivation rec {
  pname = "tdarr-server";
  version = "2.46.01";
  src = fetchzip {
    # Urls can be found here https://storage.tdarr.io/versions.json
    url = "https://storage.tdarr.io/versions/${version}/linux_x64/Tdarr_Server.zip";
    hash = "sha256-X4DMG8FgSjBBCg48GvEJH65XZUHu3nvgrzWuX5ecWq0=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  dontConfigure = true;
  dontBuild = true;

  patchPhase = ''
    # Remove bundled ffmpeg and ccextractor, since we are using the one from nixpkgs
    rm -rf ./assets/app/ffmpeg
    rm -rf ./assets/app/ccextractor
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./ $out/tdarr
    makeWrapper $out/tdarr/${binName} $out/bin/${binName} \
    --set PATH ${
      lib.makeBinPath [
        ffmpeg
        handbrake
        mkvtoolnix-cli
        ccextractor
        apprise
      ]
    }
  '';

  meta = with lib; {
    mainProgram = binName;
    description = "Distributed transcode automation";
    homepage = "https://tdarr.io";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
