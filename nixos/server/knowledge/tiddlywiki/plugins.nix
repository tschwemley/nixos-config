{pkgs, ...}: let
  relinkPlugins = pkgs.fetchFromGitHub {
    owner = "flibbles";
    repo = "tw5-relink";
    rev = "v2.4.4";
    hash = "sha256-F+ieS7Ko/p/CLM1a0U/8aLFcwU3dr6fJbk71H1hB0vU=";

    sparseCheckout = [
      "plugins"
    ];
  };
in {
  systemd.tmpfiles.rules = [
    "L+ /var/lib/tiddlywiki/plugins 0655 tiddlywiki tiddlywiki - ${relinkPlugins}/plugins/"
  ];
}
