{self, ...}: {
  default = _: prev: let
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

    # BUG: https://github.com/NixOS/nixpkgs/pull/390933/files
    bitwarden-cli = prev.bitwarden-cli.overrideAttrs (finalAttrs: {
      postConfigure = ''
        ${finalAttrs.postConfigure}

        # FIXME one of the esbuild versions fails to download @esbuild/linux-x64
        rm -r node_modules/esbuild node_modules/vite/node_modules/esbuild
        npm rebuild --verbose
      '';
    });

    oidcproxy = self.inputs.oidcproxy.packages.${system}.default;
  };
}
