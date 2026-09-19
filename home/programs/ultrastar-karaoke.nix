{ pkgs, ... }: {
  # REF: https://usdx.eu/docs/
  home.packages = with pkgs; [
    ultrastardx
    ultrastar-creator
    ultrastar-manager
  ];
}
