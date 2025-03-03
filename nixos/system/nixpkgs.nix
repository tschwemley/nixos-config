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
          trmnl-server
          wl-ocr
          ;

        # BUG: https://nixpkgs-tracker.ocfox.me/?pr=380358 -- upstream issue; remove when merged
        # inherit (inputs.nixpkgs-master.legacyPackages.${system}) khal;

        inherit (inputs.zen-browser.packages.${final.system}) zen-browser;

        # BUG: YAFB - Upstream bug with broken symlink shit.
        inherit (inputs.nixpkgs-stable.legacyPackages.${system}) bruno-cli;

        oidcproxy = inputs.oidcproxy.packages.${system}.default;

        # NOTE: can remove once none_ls plugin in nixpkgs is updated to version >= 2025-02-25
        vimPlugins =
          prev.vimPlugins
          // {
            none-ls-nvim = prev.vimUtils.buildVimPlugin {
              pname = "none-ls.nvim";
              version = "2025-02-25";
              src = prev.fetchFromGitHub {
                owner = "nvimtools";
                repo = "none-ls.nvim";
                rev = "a66b5b9ad8d6a3f3dd8c0677a80eb27412fa5056";
                sha256 = "1gigpylm05kgm91zfaxchnbwwl54aiqwiqj720ww40hk5k0zxin4";
              };
              meta.homepage = "https://github.com/nvimtools/none-ls.nvim/";
              meta.hydraPlatforms = [];
            };
          };
      })
    ];
  };
}
