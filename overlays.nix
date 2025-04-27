{self, ...}: {
  default = final: prev: let
    inherit (prev) system;
    inherit (self.inputs.nixpkgs.legacyPackages.${system}) fetchFromGitHub;
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

    ###
    # Custom defined overlays.
    # TODO:  If over time these grow then move overlays into a dir
    ###

    # BUG: upstream -> https://github.com/NixOS/nixpkgs/issues/399907
    qt6Packages =
      prev.qt6Packages
      // {
        qt6gtk2 = prev.qt6Packages.qt6gtk2.overrideAttrs {
          pname = "qt6gtk2";
          version = "0.5-unstable-2025-03-04";

          src = prev.fetchFromGitLab {
            domain = "opencode.net";
            owner = "trialuser";
            repo = "qt6gtk2";
            rev = "d7c14bec2c7a3d2a37cde60ec059fc0ed4efee67";
            hash = "sha256-6xD0lBiGWC3PXFyM2JW16/sDwicw4kWSCnjnNwUT4PI=";
          };
        };
      };

    # BUG: issue with wine versioning causing build failures for yabridge. Check periodically and
    # remove when no longer an issue.
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
  };
}
