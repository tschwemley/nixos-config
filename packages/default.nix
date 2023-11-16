{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      # see: https://github.com/NixOS/nixpkgs/pull/206495/files for merge
      # bambuStudio = pkgs.stdenv.mkDerivation {};

      localAI = pkgs.stdenv.mkDerivation {
        pname = "local-ai";
        version = "1.25.0";
        nativeBuildInputs = with pkgs; [git go ncurses];
        src = pkgs.fetchFromGitHub {
          owner = "go-skynet";
          repo = "LocalAI";
          rev = "9e5fb2996582bc45e5a9cbe6f8668e7f1557c15a";
          sha256 = "bk9mYIgwZJpLB9+aOYM2cjhOLztT8Z2Ftt++GPHptS8=";
          fetchSubmodules = true;
        };

        buildPhase = ''
          echo $src
        '';
      };
    };
  };
}
