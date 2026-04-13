{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  src = pkgs.fetchFromGitHub {
    owner = "Silvenga";
    repo = "redlib";
    rev = "72394ed320bd4437bb29e8780af0513b4ff02152";
    hash = "sha256-jiLjyp6ze3HEsr7F+eRW3DyKJBJl+EoNjQ0wpEB+xlc=";
  };

  # Use Silvenga's wreq fork (redlib-org/redlib#544) which uses BoringSSL
  # to emulate browser TLS fingerprints and evade bot detection
  redlib-fork = pkgs.redlib.overrideAttrs (oldAttrs: {
    version = "0.36.0-unstable-2026-04-04";
    inherit src;
    cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      inherit src;
      name = "redlib-0.36.0-unstable-2026-04-04-vendor";
      hash = "sha256-eO3c7rlFna3DuO31etJ6S4c7NmcvgvIWZ1KVkNIuUqQ=";
    };
    # BoringSSL (via boring-sys2) needs cmake, go, git, perl, and libclang for bindgen
    nativeBuildInputs =
      (oldAttrs.nativeBuildInputs or [ ])
      ++ (with pkgs; [
        cmake
        go
        perl
        git
        rustPlatform.bindgenHook
      ]);
    checkFlags = (oldAttrs.checkFlags or [ ]) ++ [
      "--skip=oauth::tests::test_generic_web_backend"
      "--skip=oauth::tests::test_mobile_spoof_backend"
    ];
  });

  address = "127.0.0.1";
in
{
  services = {
    nginx.virtualHosts."reddit.schwem.io" = {
      locations."/" = {
        # proxyPass = "http://${address}${config.services.anubis.instances.redlib.settings.BIND}";
        proxyPass = "http://unix:${config.services.anubis.instances.redlib.settings.BIND}";
      };
    };

    redlib = {
      inherit address;

      enable = true;
      package = redlib-fork;
      port = lib.toInt self.lib.port-map.redlib;

      # REF: https://github.com/redlib-org/redlib?tab=readme-ov-file#configuration
      settings = {
        REDLIB_ROBOTS_DISABLE_INDEXING = "on";
        REDLIB_DEFAULT_THEME = "gruvboxdark";
        REDLIB_DEFAULT_SHOW_NSFW = "on";
        REDLIB_DEFAULT_USE_HLS = "on";
        REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
      };
    };
  };
}
