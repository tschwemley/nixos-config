{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  coreutils,
  ffmpeg,
  ffmpeg_8-full,
  fontconfig,
  glib,
  icu,
  libglvnd,
  libX11,
  libXrandr,
  lttng-ust,
  makeWrapper,
  openssl,
  rsync,
  libsm,
  libice,
  libxi,
  zlib,
}:
# REF: https://github.com/0x90d/videoduplicatefinder
stdenv.mkDerivation rec {
  pname = "videoduplicatefinder";
  version = "4.0.x";

  src = fetchurl {
    url = "https://github.com/0x90d/videoduplicatefinder/releases/download/${version}/GUI-linux-x64.tar.gz";
    sha256 = "sha256-jNRTv5YTacgVHgA4hxukhnETakQ10zSOyiL1L77qjgQ=";
  };

  sourceRoot = "outputGUI";

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  # lttng-ust is for tracing/profiling and not essential for basic functionality
  autoPatchelfIgnoreMissingDeps = [ "liblttng-ust.so.0" ];

  # Don't strip .NET binaries as it breaks the runtime
  dontStrip = true;

  buildInputs = [
    ffmpeg_8-full
    fontconfig
    glib
    icu
    libglvnd
    libX11
    libXrandr
    lttng-ust
    openssl
    stdenv.cc.cc.lib
    libsm
    libice
    libxi
    zlib
  ];

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/videoduplicatefinder

    # copy all application files to share directory
    cp -r . $out/share/videoduplicatefinder/

    # make the main binary executable
    chmod +x $out/share/videoduplicatefinder/VDF.GUI

    # create wrapper script that runs the app from a writable directory
    cat > $out/bin/videoduplicatefinder <<'EOF'
    #!/bin/sh
    set -e

    # use XDG_DATA_HOME or fallback to ~/.local/share
    DATA_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/videoduplicatefinder"

    # create data directory if it doesn't exist
    mkdir -p "$DATA_DIR"

    # sync application files from nix store to writable location
    # this allows the app to write logs and download files
    ${rsync}/bin/rsync -a --chmod=u+w "@out@/share/videoduplicatefinder/" "$DATA_DIR/"

    # run the application from the writable directory
    cd "$DATA_DIR"
    exec ./VDF.GUI "$@"
    EOF

    chmod +x $out/bin/videoduplicatefinder

    # substitute @out@ placeholder with actual path
    substituteInPlace $out/bin/videoduplicatefinder \
      --replace-fail "@out@" "$out"

    # wrap the script to ensure ffmpeg and libraries are available
    mv $out/bin/videoduplicatefinder $out/bin/.videoduplicatefinder-unwrapped
    makeWrapper $out/bin/.videoduplicatefinder-unwrapped $out/bin/videoduplicatefinder \
      --prefix PATH : ${
        lib.makeBinPath [
          ffmpeg
          ffmpeg_8-full
          coreutils
        ]
      } \
      --prefix LD_LIBRARY_PATH : "$out/share/videoduplicatefinder:${lib.makeLibraryPath buildInputs}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cross-platform video duplicate finder based on similarity";
    homepage = "https://github.com/0x90d/videoduplicatefinder";
    license = licenses.agpl3Only;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "videoduplicatefinder";
  };
}
