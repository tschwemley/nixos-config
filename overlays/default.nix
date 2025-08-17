self:
let
  default =
    _: prev:
    let
      inherit (prev) system;
    in
    {
      inherit (self.packages.${system})
        json2go
        nrepl
        scripts
        trmnl-server
        wl-ocr
        ;

      oidcproxy = self.inputs.oidcproxy.packages.${system}.default;
    };
in
{
  inherit default;

  # Custom defined overlays
  # aseprite = import ./aseprite.nix;
  charm = import "${self.inputs.charm}/overlay.nix";
  vimPlugins = import ./vimplugins.nix self;
  visidata = import ./visidata.nix;
  zen-browser = import ./zen-browser.nix self;

  # Overlays defined via inputs
  neovim = self.inputs.neovim-overlay.overlays.default;

  # nix-topology = self.inputs.nix-topology.overlays.default;
}
