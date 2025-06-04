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

    # TODO: remove if not using (it may not be ready for real-world applications yet)
    zluda = prev.zluda.overrideAttrs (oldAttrs: {
      env = oldAttrs.env // {CMAKE_BUILD_TYPE = "release";};
    });
  };
in {
  inherit default;

  aseprite = import ./aseprite.nix;
  neovim = self.inputs.neovim-overlay.overlays.default;
  vimPlugins = import ./vimplugins.nix self;
  zen-browser = import ./zen-browser.nix self;

  # NOTE: Below is the old default implmenentation for reference. Remove when refactor validated.

  # TODO: Slowly refactor out the old default defined overlay
  # default = _: prev: let
  #   inherit (prev) system;
  # in {
  #   inherit
  #     (self.packages.${system})
  #     json2go
  #     nrepl
  #     scripts
  #     trmnl-server
  #     wl-ocr
  #     ;
  #
  #   oidcproxy = self.inputs.oidcproxy.packages.${system}.default;

  # TODO: validate removal is fine
  #
  # vimPlugins =
  #   prev.vimPlugins
  #   // self.packages.${system}.extraVimPlugins
  #   // {
  #     # TODO: can be removed as soon as nixpkgs has version >= 2025-04-30
  #     none-ls-nvim = prev.vimUtils.buildVimPlugin {
  #       pname = "none-ls.nvim";
  #       version = "2025-04-26";
  #       src = prev.fetchFromGitHub {
  #         owner = "nvimtools";
  #         repo = "none-ls.nvim";
  #         rev = "0233f19bd645f22ca477c702a329ba7bc921b37b";
  #         sha256 = "0kaz9v45i36d35lrjpkyryb2ilb5wf0ixwgyw6lkryzzi8md69yz";
  #       };
  #       meta.homepage = "https://github.com/nvimtools/none-ls.nvim/";
  #       meta.hydraPlatforms = [];
  #     };
  #   };

  # TODO: delete after verifying fix
  # BUG: upstream -> https://github.com/NixOS/nixpkgs/issues/399907
  # qt6Packages =
  #   prev.qt6Packages
  #   // {
  #     qt6gtk2 = prev.qt6Packages.qt6gtk2.overrideAttrs {
  #       pname = "qt6gtk2";
  #       version = "0.5-unstable-2025-03-04";
  #
  #       src = prev.fetchFromGitLab {
  #         domain = "opencode.net";
  #         owner = "trialuser";
  #         repo = "qt6gtk2";
  #         rev = "d7c14bec2c7a3d2a37cde60ec059fc0ed4efee67";
  #         hash = "sha256-6xD0lBiGWC3PXFyM2JW16/sDwicw4kWSCnjnNwUT4PI=";
  #       };
  #     };
  #   };

  # TODO: checking... uncomment or remove based on result
  # BUG: issue with wine versioning causing build failures for yabridge. Check periodically and
  # remove when no longer an issue.
  # pinnedWine =
  #   import (fetchTarball {
  #     url = "https://github.com/NixOS/nixpkgs/archive/da466ad.tar.gz";
  #     sha256 = "04wc7l07f34aml0f75479rlgj85b7n7wy2mky1j8xyhadc2xjhv5";
  #   }) {
  #     inherit system;
  #     config = {}; # Omit or add necessary config options if required
  #   };
  #
  # wineWowPackages =
  #   prev.wineWowPackages
  #   // {
  #     inherit (final.pinnedWine.wineWowPackages) staging;
  #     stagingFull = final.pinnedWine.wineWowPackages.staging;
  #   };
  #
  # yabridge = prev.yabridge.override {
  #   wine = final.pinnedWine.wineWowPackages.staging;
  # };
  #
  # yabridgectl = prev.yabridgectl.override {
  #   wine = final.pinnedWine.wineWowPackages.staging;
  # };

  # # BUG: Can remove once upstream merged: https://nixpkgs-tracker.ocfox.me/?pr=399644
  # zluda = prev.zluda.overrideAttrs (oldAttrs: {
  #   env = oldAttrs.env // {CMAKE_BUILD_TYPE = "release";};
  # });
  # };
}
