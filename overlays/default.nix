self': [
  (import ./forgejo.nix)
  (_: prev: {
    inherit (self'.packages)
      anonymous-overflow
      hypreasymotion
      json2go
      ogen
      wl-ocr
      ;

    vimPlugins = prev.vimPlugins // {
      inherit (self'.packages) codecompanion;
    };
  })
]
