{
  fetchFromGitHub,
  nix-update-script,
  vimUtils,
}:
vimUtils.buildVimPlugin {
  pname = "blink-cmp-env";
  version = "2025-03-23";
  src = fetchFromGitHub {
    owner = "bydlw98";
    repo = "blink-cmp-env";
    rev = "700b6d9542b9d5deea80121abbb46b1400ace302";
    hash = "sha256-inLSnrm32k1G/lCUr+VVZBKaY9DZ7PB65BHAQ5Qpti8=";
  };
  meta.homepage = "https://github.com/bydlw98/blink-cmp-env/";
  meta.hydraPlatforms = [];
  passthru.updateScript = nix-update-script {};
}
