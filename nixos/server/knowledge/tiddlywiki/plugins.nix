{pkgs, ...}: let
  relinkPlugins = pkgs.stdenv.mkDerivation {
    name = "tiddlywikiPlugins-flibbles";
    src = pkgs.fetchFromGitHub {
      owner = "flibbles";
      repo = "tw5-relink";
      rev = "v2.4.4";
      hash = "sha256-AZtbakbRM3nFcXkDTDkhMZlFG1h9Fiw7t0MNCZ1/LfY=";
    };

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir $out
      cp -r $src/plugins $out/

      runHook postInstall
    '';
  };
in {
  systemd.tmpfiles.rules = [
    "L+ /var/lib/tiddlywiki/plugins 0655 tiddlywiki tiddlywiki - ${relinkPlugins}/plugins"
  ];
}
