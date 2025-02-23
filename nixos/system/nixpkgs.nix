{
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      inputs.nil.overlays.nil

      # TODO: move this to flake.overlays and then import the same as overlays above
      (final: prev: let
        inherit (final.pkgs) system;
      in {
        inherit
          (self.packages.${system})
          anonymous-overflow
          json2go
          wl-ocr
          ;

        # BUG: https://nixpkgs-tracker.ocfox.me/?pr=380358 -- upstream issue; remove when merged
        # inherit (inputs.nixpkgs-master.legacyPackages.${system}) khal;

        inherit (inputs.zen-browser.packages.${final.system}) zen-browser;

        # BUG: YAFB - Upstream bug with broken symlink shit.
        inherit (inputs.nixpkgs-stable.legacyPackages.${system}) bruno-cli;

        oidcproxy = inputs.oidcproxy.packages.${system}.default;
      })
    ];
  };
}
