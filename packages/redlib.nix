{
  cacert,
  cmake,
  fetchFromGitHub,
  git,
  lib,
  nix-update-script,
  nixosTests,
  perl,
  pkg-config,
  rustPlatform,
  sqlite,
  zstd,
}:
rustPlatform.buildRustPackage {
  pname = "redlib";
  version = "ship-2026-11-09-692339c";

  src = fetchFromGitHub {
    owner = "agandhi4";
    repo = "redlib";
    rev = "692339c23f2e09290173fb7c2fee5f53d0ece3a1";
    hash = "sha256-mhF/gpiCSmbtIQnRyJXkX9IgaSATRhVPJP/1PVuGo2Q=";
  };

  cargoHash = "sha256-tY+e6JWFVyKGNuDcxmomuWxpW5pqvhFCsGNLODUccKs=";

  nativeBuildInputs = [
    cmake
    git
    perl
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    sqlite
    zstd
  ];

  # BoringSSL's build script invokes CMake; Redlib itself is not a CMake project.
  dontUseCmakeConfigure = true;

  checkFlags = [
    # These tests try to connect to Reddit.
    # utils.rs
    "--skip=test_fetching_subreddit_quarantined"
    "--skip=test_fetching_nsfw_subreddit"
    "--skip=test_fetching_ws"

    # client.rs
    "--skip=test_obfuscated_share_link"
    "--skip=test_share_link_strip_json"
    "--skip=test_localization_popular"
    "--skip=test_private_sub"
    "--skip=test_banned_sub"
    "--skip=test_gated_sub"
    "--skip=test_default_subscriptions"
    "--skip=test_rate_limit_check"

    # subreddit.rs
    "--skip=test_fetching_subreddit"
    "--skip=test_gated_and_quarantined"

    # user.rs
    "--skip=test_fetching_user"

    # These tests try to connect to the OAuth client.
    # oauth.rs
    "--skip=test_oauth_client"
    "--skip=test_oauth_client_refresh"
    "--skip=test_oauth_token_exists"
    "--skip=test_oauth_headers_len"
    "--skip=oauth::test_generic_web_backend"
    "--skip=oauth::test_mobile_spoof_backend"
  ];

  env = {
    SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
  };

  passthru = {
    tests = nixosTests.redlib;
    updateScript = nix-update-script {
      extraArgs = [ "--version=branch" ];
    };
  };

  meta = {
    description = "Private front-end for Reddit (Continued fork of Libreddit)";
    homepage = "https://github.com/agandhi4/redlib";
    license = lib.licenses.agpl3Only;
    mainProgram = "redlib";
  };
}
