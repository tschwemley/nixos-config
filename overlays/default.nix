self:
let
  default =
    _: prev:
    let
      inherit (prev.stdenv.hostPlatform) system;
    in
    {
      # BUG: https://nixpkgs-tracker.ocfox.me/?pr=480871
      # TODO:remove after upstream pr merged  -- should be within a few days of 01/19/26
      inherit (self.inputs.nixpkgs-small.legacyPackages.${system}) pagmo2;

      inherit (self.packages.${system})
        json2go
        nrepl
        # scripts
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
  formats = import ./formats;
  vimPlugins = import ./vimplugins.nix self;
  visidata = import ./visidata.nix;
  yaziPlugins = import ./yaziplugins.nix self;

  # Overlays defined via inputs
  neovim = self.inputs.neovim-nightly-overlay.overlays.default;
  # nix-topology = self.inputs.nix-topology.overlays.default;
}
