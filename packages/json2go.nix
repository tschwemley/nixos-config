{
  buildGoModule,
  fetchFromGitHub,
  lib,
  nix-update-script,
}:
let
  version = "1.2.3";
in
buildGoModule {
  inherit version;

  pname = "json2go";

  src = fetchFromGitHub {
    owner = "m-zajac";
    repo = "json2go";
    rev = "v${version}";
    hash = "sha256-ztqCRqIh/ocIBLjRBxPuNgeDXLSgqXfe7VkX1lvxh0s=";
  };

  vendorHash = "sha256-3Bl3BZe9CZ0KybDHPcRRauL0Zz5J1YR7uzcZIXgkv3c=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Provides utilities for creating go type representation from json inputs";
    homepage = "https://github.com/m-zajac/json2go";
    license = lib.licenses.mit;
  };
}
