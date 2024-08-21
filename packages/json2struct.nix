{
  buildGoModule,
  lib,
  fetchFromGitHub,
}:
buildGoModule {
  pname = "json2go";
  version = "1.1.4";

  src = fetchFromGitHub {
    owner = "m-zajac";
    repo = "json2go";
    rev = "69f8d7e3f9e756b10e76c040097ab75f239eab81";
    hash = "sha256-llSuwIGTz02sGVTFeyVV07fNIo2nM7xapbB5Gdikc+w=";
  };

  vendorHash = "sha256-nkxidf1Wc1LuNyBV4tmO5Swv0eYBR5rhIqSUDZqXgU4=";

  meta = {
    description = "Provides utilities for creating go type representation from json inputs";
    homepage = "https://github.com/m-zajac/json2go";
    license = lib.licenses.mit;
  };
}
