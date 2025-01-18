{
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "aspnetcore-runtime-6.0.36"
        "dotnet-sdk-6.0.428"
        "electron-31.7.7" # TODO: fix electron version
      ];
    };

    overlays = [
      (final: _: {
        inherit
          (self.packages.${final.pkgs.system})
          anonymous-overflow
          json2go
          wl-ocr
          ;

        inherit (inputs.zen-browser.packages.${final.system}) zen-browser;
      })
    ];
  };
}
