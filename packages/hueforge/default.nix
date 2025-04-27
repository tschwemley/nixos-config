{appimageTools}:
appimageTools.wrapType2 rec {
  pname = "hueforge";
  version = "0.9.0-beta-1";
  src = builtins.fetchTarball {
    url = "./HueForge_Linux_v${version}.tgz";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
}
