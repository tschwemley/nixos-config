pkgs: {
  hypreasymotion = with pkgs;
    stdenv.mkDerivation rec {
      name = "hypreasymotion";
      pname = name;

      src = fetchFromGitHub {
        owner = "zakk4223";
        repo = "hyprland-easymotion";
        rev = "b96fc643b4b262b76515e8a40cdf35b07adc8686";
        hash = "sha256-tyW4NdJKz3/SQpwyXETRJ43681F7aGWsUCCTWlz44aE=";
      };

      nativeBuildInputs = [
        pkg-config
        hyprland
      ];

      buildInputs = [hyprland] ++ hyprland.buildInputs;

      buildPhase = ''
        make all
      '';

      installPhase = ''
        mkdir -p $out/lib
        cp ./hypreasymotion.so $out/lib/libhypreasymotion.so
      '';
    };
  hyprscroller = with pkgs;
    stdenv.mkDerivation rec {
      name = "hyprscroller";
      pname = name;

      src = fetchFromGitHub {
        owner = "dawsers";
        repo = "hyprscroller";
        rev = "5c01aac850c21451a5697a6fd7959424b247fe6a";
        hash = "sha256-gd0LyHbznXzX/Jgq8ra5oux7FuamCRyo8IzckTb70Eg=";
      };

      nativeBuildInputs = [
        cmake
        pkg-config
        hyprland
      ];

      buildInputs = [hyprland] ++ hyprland.buildInputs;

      buildPhase = ''
        make all
      '';

      installPhase = ''
        mkdir -p $out/lib
        cp ./hyprscroller.so $out/lib/libhyprscroller.so
      '';
    };
}
