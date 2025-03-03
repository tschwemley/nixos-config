{
  lib,
  imagemagick,
  firefox-bin,
  playwright,
  python313,
  stdenv,
}: let
  python = (python313.withPackages
    (pythonPkgs: (
      with pythonPkgs; [
        channels
        daphne
        django_5
        playwright
        wand
        python-dotenv
        # pkgs.imagemagick
        # ./static
      ]
    )))
  .override {ignoreCollisions = true;};
in
  stdenv.mkDerivation {
    buildInputs = [
      python
      imagemagick
      firefox-bin
      playwright
      #./static
    ];

    buildPhase = ''
      runHook preBuild

      mkdir -p $out/{bin,lib}

      python manage.py migrate
      python manage.py collectstatic --noinput

      echo "\n\n----------\n\n"
      ls -alh

      exit 1

      runHook postBuild
    '';
  }
