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

    nativeBuildInputs = [python];

    buildInputs = [
      # python
      imagemagick
      firefox-bin
      playwright
      #./static
    ];

    # buildPhase = ''
    #   runHook preBuild
    #
    #   mkdir -p $out/{bin,lib}
    #
    #   runHook postBuild
    # '';

    installPhase = ''
      runHook preInstall

      # create necessary top-level out dirs
      mkdir -p $out/{bin,lib}

      # create dir in lib for trmnl server and copy necessary files
      mkdir $out/lib/trmnl-server
      cp -r ./{byos_django,templates,trmnl} $src/{LICENSE,manage.py} $out/lib/trmnl-server/

      # build static files and copy to lib
      python manage.py collectstatic --noinput
      cp -r ./static $out/lib/trmnl-server

      # create a wrapper script for python manage.py and copy to out dir as trmnl-server binary
      cat > $out/bin/trmnl-server <<EOF # bash
      ${lib.getExe python} $out/lib/trmnl-server/manage.py "\$@"
      EOF
      chmod +x $out/bin/trmnl-server

      runHook postInstall
    '';
  }
