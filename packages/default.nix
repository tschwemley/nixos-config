pkgs: let
  vimPlugins = import ./vimPlugins pkgs;
in {
  inherit (vimPlugins) vlog;

  anonymous-overflow = pkgs.callPackage ./anonymousoverflow {};
  build-host = pkgs.callPackage ./utils/build-hosts.nix pkgs;
  compose2nix = pkgs.callPackage ./utils/compose2nix.nix {};
  json2go = pkgs.callPackage ./json2go.nix {};
  ogen = pkgs.callPackage ./ogen-go.nix {};
  raindrop = pkgs.callPackage ./raindrop.nix {};
  wl-ocr = pkgs.callPackage ./wl-ocr {};
}
