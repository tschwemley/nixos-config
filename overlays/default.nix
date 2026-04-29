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

      # TODO: remove me after nixpkgs-unstable has davfs2 >= 1.7.3
      davfs2 = prev.davfs2.overrideAttrs (
        finalAttrs: prevAttrs: {
          version = "1.7.3";

          src = prev.fetchurl {
            url = "mirror://savannah/davfs2/davfs2-${finalAttrs.version}.tar.gz";
            sha256 = "sha256-pTaBYetQVWUdfl6BgMFgbaleeMlBtruKkobfeSPPy6k=";
          };
        }
      );

      oidcproxy = self.inputs.oidcproxy.packages.${system}.default;
    };
in
{
  inherit default;

  # Custom defined overlays
  # charm = import "${self.inputs.charm}/overlay.nix";
  sops = import ./sops;
  vimPlugins = import ./vimplugins.nix self;
  yaziPlugins = import ./yaziplugins.nix self;

  # Overlays defined via inputs
  comfyui = self.inputs.comfyui-nix.overlays.default;
  neovim = self.inputs.neovim-nightly-overlay.overlays.default;

  # TODO: use/modify for local pixel-art workflow or remove - 03/29/2026
  # aseprite = import ./aseprite.nix;
}
