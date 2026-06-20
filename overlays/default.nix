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
      # openclaw = self.inputs.llm-agents.packages.${self.lib.system prev}.openclaw.overrideAttrs (
      #   finalAttrs: prevAttrs: {
      #     src = prev.fetchFromGitHub {
      #       owner = "openclaw";
      #       repo = "openclaw";
      #       rev = "v${finalAttrs.version}";
      #       hash = "sha256-SllmrkkbIFwznUhZ6zogmQ91oCao6d0fMI5473jjrU0=";
      #     };
      #   }
      # );

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

  # TODO: use/modify for local pixel-art workflow or remove - 03/29/2026
  # aseprite = import ./aseprite.nix;
}
