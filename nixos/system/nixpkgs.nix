{
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      # hyprland overlays
      # inputs.hypridle.overlays.default
      # inputs.hyprland.overlays.default
      # inputs.hyprland-plugins.overlays.default
      # inputs.hyprlock.overlays.default
      # inputs.hyprpaper.overlays.default

      # self.overlays.zen-browser

      # TODO: just move this to flake.overlays and then import the same as overlays above
      (final: _: {
        inherit
          (self.packages.${final.pkgs.system})
          anonymous-overflow
          json2go
          wl-ocr
          ;

        # BUG: [01-23-25]: https://github.com/NixOS/nixpkgs/pull/375850
        # TODO: remove when resolved upstream
        inherit
          (inputs.nixpkgs-stable.legacyPackages.${final.system})
          bambu-studio
          # rocmPackages
          ;

        inherit (inputs.zen-browser.packages.${final.system}) zen-browser;
      })
    ];
  };
}
