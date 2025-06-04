_: prev: {
  # aseprite = with prev; let
  #   # pythonldlibpath = prev.lib.makeLibraryPath (with prev; [
  #   pythonldlibpath = lib.makeLibraryPath [
  #     zlib
  #     zstd
  #     stdenv.cc.cc
  #     curl
  #     openssl
  #     attr
  #     libssh
  #     bzip2
  #     libxml2
  #     acl
  #     libsodium
  #     util-linux
  #     xz
  #     # systemd
  #   ];
  # in
  #   symlinkJoin {
  #     name = "aseprite";
  #     paths = [
  #       pythonldlibpath
  #       python311
  #       python3Packages.torchWithRocm
  #       # stdenv.cc.cc
  #     ];
  #     buildInputs = [pkgs.makeWrapper];
  #     postBuild =
  #       #bash
  #       ''
  #         # wrapProgram "$out/bin/python3.12" --prefix "LD_LIBRARY_PATH" : "${pythonldlibpath}"
  #         wrapProgram "$out/bin/aseprite --prefix "LD_LIBRARY_PATH" : "${pythonldlibpath}"
  #       '';
  #   };

  name = "aseprite-wrapped";
  paths = with prev; let
    # pythonldlibpath = prev.lib.makeLibraryPath (with prev; [
    pythonldlibpath = lib.makeLibraryPath [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
    ];

    patchedpython = python311.overrideAttrs (
      previousAttrs: {
        # Add the nix-ld libraries to the LD_LIBRARY_PATH.
        # creating a new library path from all desired libraries
        postInstall =
          previousAttrs.postInstall
          + ''
            mv  "$out/bin/python3.11" "$out/bin/unpatched_python3.11"
            cat << EOF >> "$out/bin/python3.11"
            #!/run/current-system/sw/bin/bash
            export LD_LIBRARY_PATH="${pythonldlibpath}"
            exec "$out/bin/unpatched_python3.11" "\$@"
            EOF
            chmod +x "$out/bin/python3.11"
          '';
      }
    );
  in [
    aseprite
    patchedpython
    python3Packages.torchWithRocm
    stdenv.cc.cc
  ];
}
