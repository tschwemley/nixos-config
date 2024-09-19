self': [
  (_: prev: {
    inherit (self'.packages)
      anonymous-overflow
      hypreasymotion
      json2go
      ogen
      stash
      wl-ocr
      ;

    vimPlugins = prev.vimPlugins // {
      inherit (self'.packages) codecompanion;
    };
  })
]
