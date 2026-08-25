{
  fetchFromGitHub,
  nix-update-script,
  vimUtils,
}:
vimUtils.buildVimPlugin {
  pname = "videre.nvim";
  version = "5e7b39b";

  src = fetchFromGitHub {
    owner = "Owen-Dechow";
    repo = "videre.nvim";
    rev = "5e7b39bb17d7381b06bcaae589c2d53854ae5c93";
    hash = "sha256-SFFIae04TWWf8ndode4TlQZa3TZWhQlNl3YqfWaJeVg=";
  };

  nvimSkipModules = [
    "videre.langs.toml"
    "videre.langs.xml"
    "videre.langs.yaml"
  ];

  meta.homepage = "https://github.com/Owen-Dechow/videre.nvim";
  passthru.updateScript = nix-update-script { };
}
