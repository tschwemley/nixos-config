self': [
  (_: prev: {
    inherit (self'.packages)
      anonymous-overflow
      hypreasymotion
      json2go
      wl-ocr
      ;

    forgejo = prev.forgejo.override {
      postInstall = ''
        mv $out/bin/gitea $out/bin/forgejo
        ${builtins.replaceStrings [ "gitea" ] [ "forgejo" ] prev.forgejo}
      '';
    };

    vimPlugins = prev.vimPlugins // {
      inherit (self'.packages) codecompanion;
    };
  })
]
