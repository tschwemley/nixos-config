{
  fetchFromGitHub,
  nix-update-script,
  numr,
  vimUtils,
}:
let
  pname = "nvumi";
  version = "2.1.0";
in
(vimUtils.buildVimPlugin {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "josephburgess";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-fXthRlTp2AQSLQHtjoCpgMRdNA9hqV4W8Cd0+4ZM8Ak=";
  };
  meta.homepage = "https://github.com/josephburgess/nvumi/";
  meta.hydraPlatforms = [ ];
  passthru.updateScript = nix-update-script { };
})

# REF: https://github.com/josephburgess/nvumi
