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
        trmnl-server
        wl-ocr
        ;

      oidcproxy = self.inputs.oidcproxy.packages.${system}.default;

      # BUG: fixes broken linuxPackages_zen. Remove after upstream is in nixos-unstable.
      # UPSTREAM: https://nixpkgs-tracker.ocfox.me/?pr=482971
      inherit (self.inputs.nixpkgs-small.legacyPackages.${system}) linuxPackages_zen;
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
