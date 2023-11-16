{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      bambuStudio = pkgs.stdenv.mkDerivation rec {
        builder = "${pkgs.bash}/bin/bash";
        pname = "bambu-studio";
        version = "01.07.04.52";
        src = pkgs.fetchFromGitHub {
          repo = "BambuStudio";
          owner = "bambulab";
          rev = "v${version}";
          hash = "sha256-JYSSah2KiNn9jb0X/GZFFziQpP11eXc66ozh1L6Zcf0=";
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
