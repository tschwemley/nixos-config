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

  aseprite = import ./aseprite.nix;
  neovim = self.inputs.neovim-overlay.overlays.default;
  patchedPackages = import ./patched-packages.nix self;
  redlib = import ./redlib.nix;
  rocmPackages = import ./rocm-packages.nix self;
  vimPlugins = import ./vimplugins.nix self;
  zen-browser = import ./zen-browser.nix self;
}
