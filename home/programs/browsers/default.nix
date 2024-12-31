{
  inputs',
  pkgs,
  ...
}: {
  imports = [
    ./brave.nix
    ./mullvad-browser.nix
    ./ungoogled-chromium.nix
  ];

  home.packages = with pkgs; [
    inputs'.zen-browser.packages.default

    lynx
    tor-browser
  ];
}
