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
      openclaw = self.inputs.llm-agents.packages.${self.lib.system prev}.openclaw;
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
