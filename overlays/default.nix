self': [
  (_: prev: {
    inherit (self'.packages)
      anonymous-overflow
      hypreasymotion
      json2go
      wl-ocr
      ;

    vimPlugins = prev.vimPlugins // {
      inherit (self'.packages) codecompanion;
    };
  })
]
