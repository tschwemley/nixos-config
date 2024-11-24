# NOTE: this can be removed once upstream reaches parity with open-webui version
_: prev: {
  open-webui = prev.open-webui.overrideAttrs (oldAttrs: rec {
    version = "0.4.4";

    src = prev.fetchFromGitHub {
      owner = "open-webui";
      repo = "open-webui";
      rev = "refs/tags/v${version}";
      hash = "sha256-KbU8g9iqz7ow2Yxl5EizcYckMOHGGsEK5HkkchSXxQo=";
    };

    buildInputs = with prev.python311.pkgs; let
      opensearch-py = prev.python311.pkgs.opensearch-py.overrideAttrs {
        disabledTests =
          # finds our ca-bundle, but expects something else (/path/to/clientcert/dir or None)
          [
            "test_ca_certs_ssl_cert_dir"
            # finds our ca-bundle, but expects something else (/path/to/clientcert/dir or None)
            "test_no_ca_certs"
            "test_ca_certs_ssl_cert_dir"
            "test_no_ca_certs"

            # Failing tests, issue opened at https://github.com/opensearch-project/opensearch-py/issues/849
            "test_basicauth_in_request_session"
            "test_callable_in_request_session"
          ];
      };
    in
      [
        aiocache
        ldap3
        opensearch-py
        pgvector
        soundfile
      ]
      ++ oldAttrs.buildInputs;
  });
}
