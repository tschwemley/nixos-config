{
  lib,
  cacert,
  cmake,
  fetchpatch,
  git,
  perl,
  nixosTests,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "redlib";
  version = "v0.40.0-patched";

  src = fetchFromGitHub {
    owner = "redlib-org";
    repo = "redlib";
    rev = "ba116c1186f6b0f9d45f0ae50c827e13eb2f5ea2";
    hash = "sha256-qv7vIls9BwgwDQuKEQU72J10MpaMfcLvIGfzl628eNU=";
  };

  cargoHash = "sha256-XgHXqH4EF8TEOI+cKJ0Z2j6QYRCwGgv8bmY8gZpPN9c=";

  patches = [
    (fetchpatch {
      url = "https://github.com/redlib-org/redlib/pull/603.diff";
      hash = "sha256-o0bnV81Sp3wiePOe11sFeLRJFmBPdmfE7dtXumvk1fc=";
    })
  ];

  nativeBuildInputs = [
    cmake
    git
    perl
    rustPlatform.bindgenHook
  ];

  # BoringSSL's build script invokes CMake; Redlib itself is not a CMake project.
  dontUseCmakeConfigure = true;

  # postInstall = ''
  #   install --mode=444 -D contrib/redlib.service $out/lib/systemd/system/redlib.service
  #   substituteInPlace $out/lib/systemd/system/redlib.service \
  #     --replace-fail "/usr/bin/redlib" "$out/bin/redlib"
  # '';

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
    "--skip=oauth::tests::test_mobile_spoof_backend"
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
    maintainers = with lib.maintainers; [
      bpeetz
      Guanran928
    ];
  };
}
