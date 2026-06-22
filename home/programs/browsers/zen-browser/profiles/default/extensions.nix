self: pkgs: {
  packages = with self.inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
    bitwarden
    chrome-mask
    facebook-container
    kagi-privacy-pass
    kagi-search
    libredirect
    localcdn
    multi-account-containers
    search-by-image
    stylus
    ublock-origin
    violentmonkey
    vimium
    web-archives

    # TODO: maybe list:
    #   - https://addons.mozilla.org/en-US/firefox/addon/zen-internet/
  ];
}
