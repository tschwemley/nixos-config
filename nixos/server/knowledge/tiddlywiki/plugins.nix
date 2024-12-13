{pkgs, ...}: let
  tiddlywikiPlugins = pkgs.stdenvNoCC.mkDerivation {
    name = "tiddlywikiPlugins";

    srcs = [
      # projectify plugin
      (pkgs.fetchFromGitHub {
        owner = "ThaddeusJiang";
        repo = "projectify";
        rev = "0.14.3";
        hash = "sha256-2WyZUaBP+BB9ysmxkrUNcGQLPJJuC/8116myn5s6LXU=";
      })
      # relink plugins
      (pkgs.fetchFromGitHub {
        owner = "flibbles";
        repo = "tw5-relink";
        rev = "v2.4.4";
        hash = "sha256-AZtbakbRM3nFcXkDTDkhMZlFG1h9Fiw7t0MNCZ1/LfY=";
      })
    ];

    unpackPhase = ''
      runHook preUnpack;

      mkdir -p $out/plugins
      for _src in $srcs; do
        cp -r $_src/plugins/* $out/plugins/
      done

      runHook postUnpack;
    '';

    dontBuild = true;
  };
in {
  systemd.services.tiddlywiki = {
    environment = {
      TIDDLYWIKI_PLUGIN_PATH = "${tiddlywikiPlugins}";
    };
  };
}
