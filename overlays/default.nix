self:
let
  default =
    _: prev:
    let
      inherit (prev.stdenv.hostPlatform) system;
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
  yaziPlugins = import ./yaziplugins.nix self;

  # Overlays defined via inputs
  # hypridle = self.inputs.hypridle.overlays.default;
  # hyprland = self.inputs.hyprland.overlays.default;
  # hyprlock = self.inputs.hyprlock.overlays.default;
  neovim = self.inputs.neovim-nightly-overlay.overlays.default;

  # nix-topology = self.inputs.nix-topology.overlays.default;
}
