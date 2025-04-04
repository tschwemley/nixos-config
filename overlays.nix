{self, ...}: {
  default = final: prev: let
    inherit (prev) system;
  in {
    inherit
      (self.packages.${system})
      anonymous-overflow
      json2go
      nrepl
      scripts
      trmnl-server
      wl-ocr
      ;

    inherit (self.inputs.zen-browser.packages.${system}) zen-browser;

    # Non-inherited but sourced from inputs or packages
    oidcproxy = self.inputs.oidcproxy.packages.${system}.default;
    vimPlugins = prev.vimPlugins // self.packages.${system}.extraVimPlugins;

    # Custom defined overlays. If overtime these grow then move overlays into a dir
    # FIXME: remove this after upstream fix: https://github.com/NixOS/nixpkgs/issues/375460
    pinnedWine =
      import (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/da466ad.tar.gz";
        sha256 = "04wc7l07f34aml0f75479rlgj85b7n7wy2mky1j8xyhadc2xjhv5";
      }) {
        inherit system;
        config = {}; # Omit or add necessary config options if required
      };

    wineWowPackages =
      prev.wineWowPackages
      // {
        inherit (final.pinnedWine.wineWowPackages) staging;
        stagingFull = final.pinnedWine.wineWowPackages.staging;
      };

    yabridge = prev.yabridge.override {
      wine = final.pinnedWine.wineWowPackages.staging;
    };

    yabridgectl = prev.yabridgectl.override {
      wine = final.pinnedWine.wineWowPackages.staging;
    };
    # ENDFIXME
  };
}
