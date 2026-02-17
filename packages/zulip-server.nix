{
  stdenv,
}:
let
  version = "11.5";
in
stdenv.mkDerivation {
  inherit version;
  name = "zulip-server";

  src = fetchTarball {
    url = "https://github.com/zulip/zulip/releases/download/${version}/zulip-server-${version}.tar.gz";
    sha256 = "01f4z1pbbbh7jq6wdmgp950jsvfax6jnqhs1mq8pshwmfln3y3zi";
  };

  buildPhase = ''
    runHook preBuild

    cp -r $src $out

    runHook postBuild
  '';
}
