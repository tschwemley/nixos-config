{pkgs, ...}:
with pkgs;
  stdenv.mkDerivation rec {
    pname = "wivrn";
    version = "0.14.1";
    src = fetchFromGitHub {
      owner = "Meumeu";
      repo = "WiVRn";
      rev = "v${version}";
      hash = pkgs.lib.fakeHash;
    };
    nativeBuildInputs = [
      cmake
    ];

    buildInputs = [
      avahi
      eigen
      ffmpeg
      libdrm
      libpulse
      nlohmann_json
      x264
    ];

    buildPhase = ''
      cmake -B build-server . -GNinja -DWIVRN_BUILD_CLIENT=OFF -DCMAKE_BUILD_TYPE=RelWithDebInfo
      cmake --build build-server
    '';
  }
