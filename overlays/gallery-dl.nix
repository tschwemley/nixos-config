_: prev:
let
  version = "20260620-master";
in
{
  gallery-dl = prev.gallery-dl.overridePythonAttrs {
    inherit version;
    src = prev.fetchFromCodeberg {
      owner = "mikf";
      repo = "gallery-dl";
      rev = "8da291266afdf3cbab92d2296ff8b49a706ea23b";
      # tag = "v${version}";
      hash = "sha256-P3JXLaSuzwZEfFiip1TjXYcPeeUV+Wg9X8JGHur3NxA=";
    };
  };
}
