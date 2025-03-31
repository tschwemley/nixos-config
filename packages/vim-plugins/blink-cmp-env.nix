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
    rev = "491eb6170834c2a5e855bb0b962313376228472e";
    sha256 = "04776yv6qm00wjjd005gm7q333v7islwifpch1hmypzsqj1k3pnm";
  };
  meta.homepage = "https://github.com/bydlw98/blink-cmp-env/";
  meta.hydraPlatforms = [];
  passthru.updateScript = nix-update-script {};
}
