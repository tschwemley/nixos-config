{ self, ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      hyprlandPlugins = import ./hyprlandPlugins pkgs;
      vimPlugins = import ./vimPlugins pkgs;
    in
    {
      packages = {
        inherit (hyprlandPlugins) hypreasymotion hyprscroller;
        inherit (vimPlugins) codecompanion;

        anonymous-overflow = pkgs.callPackage ./anonymousoverflow { };
        build-host = pkgs.callPackage ./utils/build-hosts.nix { inherit self; };
        compose2nix = pkgs.callPackage ./utils/compose2nix.nix { };
        json2go = pkgs.callPackage ./json2go.nix { };
        ogen = pkgs.callPackage ./ogen-go.nix { };
        wl-ocr = pkgs.callPackage ./wl-ocr { };
      };
    };
}
