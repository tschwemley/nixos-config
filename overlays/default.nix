self:
let
  default =
    final: prev:
    let
      inherit (prev.stdenv.hostPlatform) system;
    in
    {
      inherit (self.packages.${system})
        json2go
        nrepl
        trmnl-server
        wl-ocr
        ;

      inherit (self.inputs.neovim-nightly-overlay.packages.${system}) tree-sitter;

      oidcproxy = self.inputs.oidcproxy.packages.${system}.default;
    };
in
{
  inherit default;

  # Custom defined overlays
  # charm = import "${self.inputs.charm}/overlay.nix";
  sops = import ./sops;
  vimPlugins = import ./vimplugins.nix self;
  visidata = import ./visidata.nix;
  yaziPlugins = import ./yaziplugins.nix self;

  # Overlays defined via inputs
  neovim = self.inputs.neovim-nightly-overlay.overlays.default;

  # TODO: use/modify for local pixel-art workflow or remove - 03/29/2026
  # aseprite = import ./aseprite.nix;
}
