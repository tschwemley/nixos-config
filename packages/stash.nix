{
  fetchurl,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "stash";
  version = "0.26.2";

  src = fetchurl {
    url = "https://github.com/stashapp/stash/releases/download/v${version}/stash-linux";
    hash = "sha256-w13NzlXQFMH5/iNXW56Saw3Wrlm9HWb3eidRcPxJxvo=";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/stash
    chmod +x $out/bin/stash
  '';
}
