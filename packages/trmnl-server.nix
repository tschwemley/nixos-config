{
  fetchFromGitHub,
  lib,
  imagemagick,
  firefox-bin,
  playwright,
  python313,
  python313Packages,
  stdenv,
}: let
  python = (python313.withPackages
    (pythonPkgs: (
      with pythonPkgs; [
        channels
        daphne
        django_5
        python313Packages.playwright
        wand
        python-dotenv
        # pkgs.imagemagick
        # ./static
      ]
    )))
  .override {ignoreCollisions = true;};
in
  stdenv.mkDerivation rec {
    name = "trmnl-server";
    version = "20250217";
    src = fetchFromGitHub {
      inherit version;
      owner = "usetrmnl";
      repo = "byos_django";
      rev = "fef8c3c228d201e28aa1763657fd44a66bcd55a9";
      hash = "sha256-C7lzmzU/Bzes8KOXXVTUEvr/9njn1nsuM7ccyggykhU=";
    };

    propagatedBuildInputs = [
      python
      imagemagick
      firefox-bin
      playwright
    ];

    buildPhase = ''
      runHook preBuild
      # create dir in lib for trmnl server and copy necessary files

      mkdir -p $out/{bin,lib/trmnl-server}
      cp -r ./{byos_django,templates,trmnl} $src/{LICENSE,manage.py} $out/lib/trmnl-server/

      # build static files and copy to lib
      python manage.py collectstatic --noinput
      cp -r ./static $out/lib/

      cp ${python}/bin/daphne $out/bin

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      # create a wrapper script for python manage.py and copy to out dir as trmnl-server binary
      cat > $out/bin/trmnl-server-init <<EOF # bash
      ${lib.getExe python} $out/lib/trmnl-server/manage.py migrate
      ${lib.getExe python} $out/lib/trmnl-server/manage.py createsuperuser "\$@"
      EOF

      cat > $out/bin/trmnl-server-run <<EOF # bash
      export PYTHONPATH=$out/lib/trmnl-server
      $out/bin/daphne "\$@" byos_django.asgi:application
      EOF

      chmod +x $out/bin/trmnl-server-{run,init}

      runHook postInstall
    '';
  }
