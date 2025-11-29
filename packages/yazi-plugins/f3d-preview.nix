{
  lib,
  fetchFromGitHub,
  mkYaziPlugin,
}:
mkYaziPlugin {
  pname = "f3d-preview.yazi";
  version = "2025-10-26";

  src = fetchFromGitHub {
    owner = "ruudjhuu";
    repo = "f3d-preview.yazi";
    rev = "713e8d047eda92d4dc2ab81fcdceb4061c05285c";
    hash = "sha256-lBQThxrfX+nUgOgubnwW4+Ntqyoyt9Acs7X6YyQXxyo=";
  };

  meta = {
    description = "f3d-preview.yazi";
    homepage = "https://github.com/ruudjhuu/f3d-preview.yazi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ tschwemley ];
  };
}
