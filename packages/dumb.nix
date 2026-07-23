{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule rec {
  pname = "dumb";
  version = "0-unstable-2026-03-21";

  src = fetchFromGitHub {
    owner = "rramiachraf";
    repo = "dumb";
    rev = "188d5f7e41e5fdafab88f30e1b2c3e558399b53d";
    hash = "sha256-g+MBVqdPtG8ugBfYxjIrJgGcDnikzHgHnjcCYC5vx2Y=";
  };

  # Update this with the hash reported by Nix.
  vendorHash = "sha256-A9QjEYdjwcB690PVpm0NS5vjxpl12gKtrwIMZbS7ym0=";

  # The upstream go.mod declares Go 1.24 and uses Go tool dependencies.
  # go = go_1_24;

  # nativeBuildInputs = [
  #   go
  # ];

  # don't run tests (they rely on making http http requests)
  doCheck = false;

  preBuild = ''
    # Generate Go source files from .templ files.
    go tool templ generate

    # Build the CSS bundle expected by the application.
    cat ./style/*.css \
      | go tool esbuild --loader=css --minify \
      > ./static/style.css
  '';

  ldflags = [
    "-s"
    "-w"
    "-X github.com/rramiachraf/dumb/data.Version=${version}"
  ];

  postInstall = ''
    install -Dm644 LICENSE \
      "$out/share/licenses/${pname}/LICENSE"
  '';

  passthru.updateScript = nix-update-script;

  meta = {
    description = "Private alternative front-end for Genius";
    homepage = "https://github.com/rramiachraf/dumb";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "dumb";
    platforms = lib.platforms.linux;
  };
}
