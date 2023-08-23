{...}: {
  perSystem = {pkgs, ...}: {
    packages = {
      bambuStudio = pkgs.stdenv.mkDerivation rec {
        pname = "bambu-studio";
        version = "v01.07.04.52";
        src = pkgs.fetchurl {
              url = "https://github.com/bambulab/BambuStudio/archive/refs/tags/${version}.tar.gz";
          hash = "sha256:1vrmvz2b6p142r8a2r23rjj5xn9bd6c5rhjpx8g4jz6aa8nl8rw7";
        };
        # bambuStudio = pkgs.appimageTools.wrapType2 {
        # name = "bambu-studio";
        # src = pkgs.fetchurl {
        #   url = "https://github.com/bambulab/BambuStudio/releases/download/v01.07.04.52/Bambu_Studio_linux_ubuntu-v01.07.04.52.AppImage";
        #   hash = "sha256:1s53vj3s9zjg0p1p3fxynxd5c0lw6h0lyywbc3v89zzgghvy9jpk";
        # };
        # };
      };
    };
  };
}
