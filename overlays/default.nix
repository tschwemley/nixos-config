self:
let
  default =
    final: prev:
    let
      inherit (prev.stdenv.hostPlatform) system;
    in
    {
      inherit (self.packages.${system})
        crush
        json2go
        nrepl
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
  neovim = import ./neovim.nix self;
  sops = import ./sops;
  # vimPlugins = import ./vimplugins.nix self;
  visidata = import ./visidata.nix;
  yaziPlugins = import ./yaziplugins.nix self;

  # Overlay that uses the current linux kernel version for manual generation.
  # Sometimes necessary when mismatch between default kernel and other kernels like linux zen
  # linux-manual = import ./linux-manual.nix;

  # Overlays defined via inputs
  # neovim = self.inputs.neovim-nightly-overlay.overlays.default;
}
