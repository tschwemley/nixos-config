{
  fetchFromGitHub,
  nix-update-script,
  vimUtils,
}:
vimUtils.buildVimPlugin {
  pname = "backend-wezterm";
  version = "ae840db";
  src = fetchFromGitHub {
    owner = "smart-splits-nvim";
    repo = "backend-wezterm";
    rev = "ae840db696791f638c190c3e0534d2ddfcd5e6a7";
    sha256 = "sha256-9kDZAoYqQMtSGAE9w70UtkW/DLUmmwVAwCxDxk8om1E=";
  };
  meta.homepage = "https://github.com/smart-splits-nvim/backend-wezterm";
  passthru.updateScript = nix-update-script { };
}
