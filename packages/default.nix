{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      bambuStudio = pkgs.stdenv.mkDerivation rec {
        pname = "bambu-studio";
        version = "v01.07.04.52";
        src = pkgs.fetchurl {
          url = "https://github.com/bambulab/BambuStudio/archive/refs/tags/${version}.tar.gz";
          hash = "sha256:1vrmvz2b6p142r8a2r23rjj5xn9bd6c5rhjpx8g4jz6aa8nl8rw7";
        };
      };
      localAI = pkgs.stdenv.mkDerivation {
        pname = "local-ai";
        version = "1.25.0";
        nativeBuildInputs = with pkgs; [git go ncurses];
        src = pkgs.fetchFromGitHub {
          owner = "go-skynet";
          repo = "LocalAI";
          rev = "9e5fb2996582bc45e5a9cbe6f8668e7f1557c15a";
          sha256 = "bk9mYIgwZJpLB9+aOYM2cjhOLztT8Z2Ftt++GPHptS8=";
          deepClone = true;
          fetchSubmodules = true;
        };
        makeFlags = [
          "build"
        ];
        # installTargets = "build";
      };
    };
  };
}
