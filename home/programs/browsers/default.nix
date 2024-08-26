{pkgs, ...}: {
  imports = [
    ./brave.nix
    ./librewolf.nix
    ./mullvad-browser.nix
    ./ungoogled-chromium.nix
  ];

  home.packages = with pkgs; [lynx];
}
