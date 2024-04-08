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
in {
  imports = [
    ./cardinal.nix
    (./sonic-pi.nix {inherit jackWrap pkgs;})
  ];
}
