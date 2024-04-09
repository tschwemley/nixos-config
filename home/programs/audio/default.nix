{pkgs, ...}: let
  jackWrap = drv:
    pkgs.symlinkJoin {
      name = "${drv.name}-jackwrapped";
      paths = [drv];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        ls "$out/bin"
        for b in "$out/bin/"*; do
          wrapProgram "$b" \
            --prefix LD_LIBRARY_PATH : "${pkgs.pipewire.jack}/lib"
        done
      '';
    };

  sonic-pi = import ./sonic-pi.nix {inherit jackWrap pkgs;};
in {
  imports = [
    ./cardinal.nix
    # sonic-pi
  ];
}
