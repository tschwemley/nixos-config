{
  fetchFromGitHub,
  redlib,
}:
redlib.overrideAttrs rec {
  # _: prevAttrs: {
  version = "main";

  src = fetchFromGitHub {
    owner = "redlib-org";
    repo = "redlib";
    rev = version;
    hash = "sha256-W1v7iOE60/6UyZSHQW+L+wHCoKnKUNb3kpm4LVLPZ6c=";
  };

  cargoHash = "sha256-3NQWiu/nTtHrivYL1pgxqQxEuIW0xfjxwK0ZEa2y1Kk=";
}
