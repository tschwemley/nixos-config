{
  fetchFromGitHub,
  nix-update-script,
  vimUtils,
}:
vimUtils.buildVimPlugin {
  pname = "css-vars-nvim";
  version = "2025-01-28";
  src = fetchFromGitHub {
    owner = "jdrupal-dev";
    repo = "css-vars.nvim";
    rev = "0615782c320f729b04d9c51a8a61fb498ee4234a";
    sha256 = "139s7lshc3y55gv0a5d5pjcgf85vhy8f5dz22382qa9jbj5iy32c";
  };
  meta.homepage = "https://github.com/jdrupal-dev/css-vars.nvim/";
  passthru.updateScript = nix-update-script {};
}
