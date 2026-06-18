_: prev:
let
  version = "1.32.3";
in
{
  gallery-dl = prev.gallery-dl.overridePythonAttrs {
    inherit version;
    src = prev.fetchFromCodeberg {
      owner = "mikf";
      repo = "gallery-dl";
      tag = "v${version}";
      hash = "sha256-psYM23/Q2Fh+m1UgvZgvZLmKQ42nnKhOaULLoaHV+74=";
    };
  };
}
