{
  buildGoModule,
  lib,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "AnonymousOverflow";
  version = "1.13.0";

  src = fetchFromGitHub {
    owner = "httpjamesm";
    repo = "AnonymousOverflow";
    rev = "v${version}";
    hash = "sha256-hvcOJctvNswEws+cCoeGQSvFzZvnThhKk3fJ7TnNulY=";
  };

  vendorHash = "sha256-P3kUGFJhj/pTNeVTwtg4IqhoHBH9rROfkr+ZsrUtmdo=";

  env.CGO_ENABLED = 0;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,share}
    dir="$GOPATH/bin"
    [ -e "$dir" ] && cp -r $dir/* $out/bin
    cp -r $src/{public,templates} $out/share

    runHook postInstall
  '';

  meta = {
    description = "AnonymousOverflow allows you to view StackOverflow threads without the cluttered interface and exposing your IP address, browsing habits and other browser fingerprint data to StackOverflow.";
    homepage = "https://github.com/httpjamesm/AnonymousOverflow";
    license = lib.licenses.mpl20;
  };
}
