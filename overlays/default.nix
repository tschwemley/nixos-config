self:
let
  default =
    final: prev:
    let
      inherit (prev.stdenv.hostPlatform) system;
    in
    {
      inherit (self.packages.${system})
        azeron-software
        json2go
        nrepl
        trmnl-server
        wl-ocr
        ;

      inherit (self.inputs.neovim-nightly-overlay.packages.${system}) tree-sitter;

      oidcproxy = self.inputs.oidcproxy.packages.${system}.default;

      # TODO: can remove when upstream is fixed and merged into unstable
      # UPSTREAM: https://github.com/NixOS/nixpkgs/issues/540609
      # TODO: in meantime see: github.com/flaviut/nixpkgs/commit/a846cde45365799b1fd83eafaee57c03a92d89bc
      # gdalMinimal = prev.gdal;

    };
in
{
  inherit default;

  # Custom defined overlays

  # TODO: remove me once nixpkgs has gallery-dl version >= 1.32.3
  gallery-dl = import ./gallery-dl.nix;

  sops = import ./sops;
  vimPlugins = import ./vimplugins.nix self;
  yaziPlugins = import ./yaziplugins.nix self;
}
