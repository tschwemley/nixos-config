{
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "aspnetcore-runtime-6.0.36"
      ];
    };

    overlays = [
      inputs.yazi.overlays.yazi

      (final: prev: {
        inherit
          (self.packages.${final.pkgs.system})
          anonymous-overflow
          json2go
          ogen
          wl-ocr
          ;

        inherit (inputs.zen-browser.packages.${final.system}) zen-browser;

        vimPlugins = prev.vimPlugins // {inherit (self.packages.${final.system}) vlog;};
      })
    ];

    # overlays = ()self.lib.mapAttrsToList (_: overlay: overlay) self.overlays;
  };
}
