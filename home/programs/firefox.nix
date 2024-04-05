{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})
  ];
}
