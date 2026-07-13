{
  lib,
  fetchFromGitHub,
  mkYaziPlugin,
  nix-update-script,
}:
mkYaziPlugin {
  pname = "f3d-preview.yazi";
  version = "0-unstable-2026-01-28";

  src = fetchFromGitHub {
    owner = "ruudjhuu";
    repo = "f3d-preview.yazi";
    rev = "76d115d94280828a2116aab3a46e43538f291331";
    hash = "sha256-katk13VE8J/Gn7N2Ez30/Xq0ldBV3yP2kowA0qVWYEg=";
  };

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "f3d-preview.yazi";
    homepage = "https://github.com/ruudjhuu/f3d-preview.yazi";
    license = lib.licenses.mit;
  };
}
