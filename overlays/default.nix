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
  patched-packages = import ./patched-packages.nix;
  vimPlugins = import ./vimplugins.nix self;
  zen-browser = import ./zen-browser.nix self;
}
