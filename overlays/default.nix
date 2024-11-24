self': [
  (import ./open-webui.nix)
  (import ./sops.nix)

  # define packages outputs.packages as an overlay to allow conveinent access via pkgs
  (_: prev: {
    inherit
      (self'.packages)
      anonymous-overflow
      hypreasymotion
      json2go
      ogen
      stash
      wl-ocr
      ;

    vimPlugins =
      prev.vimPlugins
      // {
        inherit (self'.packages) codecompanion vlog;
      };
  })
]
