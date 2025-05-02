lib:
lib
// rec {
  hosts = lib.attrNames (builtins.readDir ../nixos/hosts);

  flattenAttrs = attrset: builtins.concatLists (builtins.attrValues attrset);

  isPC = host: builtins.elem host ["charizard" "pikachu"];

  isServer = host: !isPC host;

  mkStrOption = attrs: lib.mkOption ({type = lib.types.str;} // attrs);

  nixpkgsPatch = system: nixpkgs:
    (import nixpkgs {
      inherit system;
      # config.allowUnfree = true;
    })
    .applyPatches {
      name = "nixpkgs-patched";
      src = nixpkgs;
      patches = import ./patches.nix;
    };

  secret = type: filename: ../secrets/${type}/${filename};

  # define secret paths as constants for convenience
  secrets = {
    home = ../secrets/home;
    nixos = ../secrets/nixos;
    server = ../secrets/server;
  };

  stringList = lib.types.listOf lib.types.str;

  # TODO: remove this once all references are switched over to config.variables.ports
  port-map = {
    anonymous-overflow = "8010";
    binternet = "8009";
    dashboard = "6980";
    excalidraw = "8380";
    forgejo = "8020";
    invidious = "3100";
    it-tools = "7001";
    nginx-sso = "8082";
    nzbhydra2 = "5076";
    oidcproxy = "1337";
    open-webui = "4141";
    priviblur = "8040";
    proxitok = "8050";
    qtbittorrentWeb = "8880";
    qtbittorrentTorrent = "8881";
    redlib = "8180";
    rimgo = "8030";
    sabnzbd = "8314";
    safetwitch-frontend = "8280";
    safetwitch-backend = "7100";
    scribe = "7000";
    searxng = "8888";
    stash = "6969";
    threadfin = "34400";
    tiddlywiki = "4242";
    webhooks = "7780";
  };
}
