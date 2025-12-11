{
  stdenv,
  lib,
  makeWrapper,
  fetchzip,
  ffmpeg,
  mkvtoolnix-cli,
  handbrake,
  ccextractor,
}:

let
  binName = "Tdarr_Node";
  # Not used at the moment
  #trayBinName = "Tdarr_Node_Tray";
in
stdenv.mkDerivation rec {
  pname = "tdarr-node";
  version = "2.46.01";
  src = fetchzip {
    # Urls can be found here https://storage.tdarr.io/versions.json
    url = "https://storage.tdarr.io/versions/${version}/linux_x64/Tdarr_Node.zip";
    hash = "sha256-JSHEzp0NwB21tZkGe3PuKOsDfDkcNfA56BXbonGOAq8=";
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
    mkdir -p $out/tdarr/assets/app
    cp -r ./ $out/tdarr
    makeWrapper $out/tdarr/${binName} $out/bin/${binName} \
      --set PATH ${
        lib.makeBinPath [
          ffmpeg
          handbrake
          mkvtoolnix-cli
          ccextractor
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
