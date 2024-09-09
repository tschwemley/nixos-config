{
  lib,
  buildGoModule,
  fetchzip,
}:
buildGoModule rec {
  pname = "ogen";
  version = "1.4.0";

  src = fetchzip {
    url = "https://github.com/ogen-go/ogen/archive/refs/tags/v${version}.zip";
    hash = "sha256-uqKHSRXJt5q0dnHDq24CKGwDBYruwxvrcOvQKPpagtQ=";
  };

  vendorHash = "sha256-IxG7y0Zy0DerCh5DRdSWSaD643BG/8Wj2wuYvkn+XzE=";

  meta = {
    description = "OpenAPI v3 code generator for Go";
    homepage = "https://ogen.dev/";
    license = lib.licenses.apsl20;
  };
}
