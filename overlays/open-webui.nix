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

    buildInputs = with prev.python311.pkgs;
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
