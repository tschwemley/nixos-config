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
