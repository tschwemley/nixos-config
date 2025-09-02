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

      # TODO: remove after merged upstream
      # UPSTREAM: https://nixpkgs-tracker.ocfox.me/?pr=437045
      python3Packages = prev.python3Packages // {
        inherit (self.inputs.nixpkgs-master.legacyPackages.${system}.python3Packages) vdirsyncer;
      };
    };
in
{
  inherit default;

  # Custom defined overlays
  # aseprite = import ./aseprite.nix;
  charm = import "${self.inputs.charm}/overlay.nix";
  redlib = import ./redlib.nix self;
  vimPlugins = import ./vimplugins.nix self;
  visidata = import ./visidata.nix;
  # zen-browser = import ./zen-browser.nix self;

  # Overlays defined via inputs
  hyprland = self.inputs.hyprland.overlays.default;
  neovim = self.inputs.neovim-overlay.overlays.default;

  # nix-topology = self.inputs.nix-topology.overlays.default;
}
