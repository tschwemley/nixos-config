{ ... }: {
  perSystem = { pkgs, ... }: {
    bambuStudio = pkgs.appImageTools.wrapType2 {
      name = "bambu-studio";
      src = builtins.fetchurl {
        url = "https://github.com/bambulab/BambuStudio/releases/download/v01.07.04.52/Bambu_Studio_linux_ubuntu-v01.07.04.52.AppImage";
        hash = "sha256-1s53vj3s9zjg0p1p3fxynxd5c0lw6h0lyywbc3v89zzgghvy9jpk";
      };
    };
  };
}
