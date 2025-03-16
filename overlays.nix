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

    oidcproxy = self.inputs.oidcproxy.packages.${system}.default;
  };
}
