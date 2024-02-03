{...}: {
  perSystem = {
    config,
    lib,
    options,
    pkgs,
    ...
  }: {
    packages = {
      prefetch-url-sha256 = pkgs.writeScriptBin "prefetch-url-sha256" ''
        hash=$(nix-prefetch-url "$1")
        nix hash to-sri --type sha256 $hash
      '';
      ollama = pkgs.callPackage ./ollama {};
      silly-tavern = pkgs.callPackage ./silly-tavern.nix {};
      # haxe-language-server = (pkgs.callPackage ../home/programs/neovim/modules/lsp/haxe-language-server {}).package;
      # haxe-language-server = let
      #   npmDeps = (pkgs.callPackage ../home/programs/neovim/modules/lsp/haxe-language-server {}).nodeDependencies;
      # in
      #   with pkgs;
      #     stdenv.mkDerivation {
      #       name = "haxe-language-server";
      #       src = fetchFromGitHub {
      #         owner = "vshaxe";
      #         repo = "haxe-language-server";
      #         rev = "10bf162b4448c00146a384e39bc8d09b23c1f434";
      #         hash = "sha256-+Hv8Svmc8FHGHo9ejhnzCYOloYwDH1YT3MpA7hx+sQ0=";
      #       };
      #       buildInputs = [haxe neko nodejs];
      #       buildPhase = ''
      #         ln -s ${npmDeps}/lib/node_modules ./node_modules
      #         export PATH="${npmDeps}/bin:$PATH"
      #       '';
      #
      #       installPhase = ''
      #         mkdir $out
      #         cp -r $src $out
      #         npm exec -- lix run vshaxe-build -t language-server
      #       '';
      #     };
    };
  };
}
