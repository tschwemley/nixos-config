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

    # BUG: https://github.com/NixOS/nixpkgs/issues/429888
    linux-manual = prev.linux-manual.overrideAttrs {
      installCheckPhase = ''
        echo "Skipping kmalloc(9) check for kernel 6.16"
      '';
    };
  };
in {
  inherit default;

  # Custom defined overlays
  aseprite = import ./aseprite.nix;
  redlib = import ./redlib.nix;
  rocmPackages = import ./rocm-packages.nix self;
  vimPlugins = import ./vimplugins.nix self;
  visidata = import ./visidata.nix;
  zen-browser = import ./zen-browser.nix self;

  # Overlays defined via inputs
  neovim = self.inputs.neovim-overlay.overlays.default;
  nix-topology = self.inputs.nix-topology.overlays.default;
}
