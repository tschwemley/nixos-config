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
        redlib # TODO: remove once https://github.com/redlib-org/redlib/pull/603 is merged
        trmnl-server
        videoduplicatefinder
        wl-ocr
        ;

      inherit (self.inputs.niri.packages.${system}) niri;
      inherit (self.inputs.neovim-nightly-overlay.packages.${system}) tree-sitter;

      # linux-zen-small =
      #   final: prev:
      #   let
      #     pkgsSmall = import self.inputs.nixpkgs-small {
      #       inherit (final.stdenv.hostPlatform) system;
      #     };
      #   in
      #   {
      #     linuxKernel = prev.linuxKernel // {
      #       packages = prev.linuxKernel.packages // {
      #         inherit (pkgsSmall.linuxKernel.packages) linux_zen;
      #       };
      #     };
      #   };

      oidcproxy = self.inputs.oidcproxy.packages.${system}.default;
    };
in
{
  inherit default;

  # Custom defined overlays

  # TODO: remove me once nixpkgs has gallery-dl version >= 1.32.3
  # gallery-dl = import ./gallery-dl.nix;

  # linux_zen_custom = import ./linux_zen_custom.nix;

  sops = import ./sops;
  vimPlugins = import ./vimplugins.nix self;
  yaziPlugins = import ./yaziplugins.nix self;
}
