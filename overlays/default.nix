self: let
  default = _: prev: let
    inherit (prev) system;
  in {
    inherit
      (self.packages.${system})
      json2go
      nrepl
      scripts
      trmnl-server
      wl-ocr
      ;

    oidcproxy = self.inputs.oidcproxy.packages.${system}.default;

    # TODO: remove once upstream merged
    # UPSTREAM: https://nixpkgs-tracker.ocfox.me/?pr=425299
    inherit (self.inputs.nixpkgs-small.legacyPackages.${system}) clisp;
    inherit (self.inputs.nixpkgs-master.legacyPackages.${system}) libguestfs;
  };
in {
  inherit default;

  # Custom defined overlays
  aseprite = import ./aseprite.nix;
  patchedPackages = import ./patched-packages.nix;
  redlib = import ./redlib.nix;
  rocmPackages = import ./rocm-packages.nix self;
  textual = import ./textual.nix self;
  vimPlugins = import ./vimplugins.nix self;
  visidata = import ./visidata.nix;
  zen-browser = import ./zen-browser.nix self;

  # Overlays defined via inputs
  neovim = self.inputs.neovim-overlay.overlays.default;
  nix-topology = self.inputs.nix-topology.overlays.default;
}
